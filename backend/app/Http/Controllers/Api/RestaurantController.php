<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Restaurant;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class RestaurantController extends Controller
{
    public function index()
    {
        $restaurants = Cache::remember('restaurants_all', 60, function () {
            return Restaurant::all()->toArray();
        });
        return response()->json(['success' => true, 'data' => $restaurants], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'         => 'required|string|max:255',
            'category'     => 'required|string|max:255',
            'latitude'     => 'required|numeric|between:-90,90',
            'longitude'    => 'required|numeric|between:-180,180',
            'rating'       => 'nullable|numeric|between:0,5',
            'album_number' => 'required|string',
        ]);

        $restaurant = Restaurant::create($validated);
        Cache::forget('restaurants_all');

        return response()->json(['success' => true, 'data' => $restaurant], 201);
    }

    public function show($id)
    {
        $restaurant = Restaurant::findOrFail($id);
        return response()->json(['success' => true, 'data' => $restaurant], 200);
    }

    public function update(Request $request, $id)
    {
        $restaurant = Restaurant::findOrFail($id);
        $validated = $request->validate([
            'name'         => 'sometimes|string|max:255',
            'category'     => 'sometimes|string|max:255',
            'latitude'     => 'sometimes|numeric|between:-90,90',
            'longitude'    => 'sometimes|numeric|between:-180,180',
            'rating'       => 'nullable|numeric|between:0,5',
            'album_number' => 'sometimes|string',
        ]);
        $restaurant->update($validated);
        Cache::forget('restaurants_all');

        return response()->json(['success' => true, 'data' => $restaurant], 200);
    }

    public function destroy($id)
    {
        $restaurant = Restaurant::findOrFail($id);
        $restaurant->delete();
        Cache::forget('restaurants_all');

        return response()->json(null, 204);
    }

    public function nearby(Request $request)
    {
        $validated = $request->validate([
            'lat'    => 'required|numeric|between:-90,90',
            'lng'    => 'required|numeric|between:-180,180',
            'radius' => 'nullable|numeric|min:0',
        ]);

        $lat    = $validated['lat'];
        $lng    = $validated['lng'];
        $radius = $validated['radius'] ?? 50;

        $cacheKey = "nearby:$lat:$lng:$radius";

        $results = Cache::remember($cacheKey, 60, function () use ($lat, $lng, $radius) {
            // Haversine formula, computed in PHP over all rows.
            // Fine at this dataset size; a DB-side Haversine query would be
            // preferable at scale, but keeps the logic explicit here.
            $restaurants = Restaurant::all();

            $withDistance = $restaurants->map(function ($restaurant) use ($lat, $lng) {
                $earthRadiusKm = 6371;

                $latDelta = deg2rad($restaurant->latitude - $lat);
                $lngDelta = deg2rad($restaurant->longitude - $lng);

                $a = sin($latDelta / 2) * sin($latDelta / 2)
                    + cos(deg2rad($lat)) * cos(deg2rad($restaurant->latitude))
                    * sin($lngDelta / 2) * sin($lngDelta / 2);

                $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
                $distanceKm = $earthRadiusKm * $c;

                $restaurant->distance_km = round($distanceKm, 2);
                return $restaurant;
            });

            return $withDistance
                ->filter(fn ($restaurant) => $restaurant->distance_km <= $radius)
                ->sortBy('distance_km')
                ->values();
        });

        return response()->json(['success' => true, 'data' => $results], 200);
    }
}