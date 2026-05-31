<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Video;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class VideoController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $videos = Cache::remember('videos:catalog:' . $request->genre . ':' . $request->page, 60, function () use ($request) {
            return Video::query()
                ->when($request->genre, function ($query, $genre) {
                    $query->where('genre', $genre);
                })
                ->orderByDesc('rating')
                ->paginate(10);
        });

        return response()->json(['data' => $videos], 200);
    }

    public function show(int $id): JsonResponse
    {
        $video = Video::findOrFail($id);
        return response()->json(['data' => $video], 200);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'title'            => 'required|string|max:255',
            'description'      => 'nullable|string',
            'genre'            => 'nullable|string',
            'duration_minutes' => 'required|integer',
            'thumbnail_url'    => 'nullable|string',
            'video_url'        => 'required|string',
            'rating'           => 'nullable|numeric',
            'album_number'     => 'required|string',
        ]);

        $video = Video::create($validated);
        Cache::flush();

        return response()->json(['data' => $video], 201);
    }
}