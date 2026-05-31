<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Watchlist;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class WatchlistController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'video_id' => 'required|integer',
        ]);

        $exists = Watchlist::where('user_id', 1)
            ->where('video_id', $validated['video_id'])
            ->exists();

        if ($exists) {
            return response()->json(['message' => 'Already in watchlist'], 409);
        }

        $watchlist = Watchlist::create([
            'user_id'  => 1,
            'video_id' => $validated['video_id'],
        ]);

        Cache::flush();
        return response()->json(['data' => $watchlist], 201);
    }

    public function destroy(int $videoId): JsonResponse
    {
        Watchlist::where('user_id', 1)
            ->where('video_id', $videoId)
            ->delete();

        Cache::flush();
        return response()->json(['message' => 'Removed from watchlist'], 200);
    }

    public function index(): JsonResponse
    {
        $watchlist = Watchlist::with('video')
            ->where('user_id', 1)
            ->get();

        return response()->json(['data' => $watchlist], 200);
    }
}