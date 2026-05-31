<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\WatchHistory;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class WatchHistoryController extends Controller
{
    public function continueWatching(): JsonResponse
    {
        $userId = 1;

        $history = WatchHistory::query()
            ->with('video')
            ->where('user_id', $userId)
            ->where('completed', false)
            ->orderByDesc('watched_at')
            ->limit(10)
            ->get();

        return response()->json(['data' => $history], 200);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'video_id'         => 'required|integer',
            'progress_seconds' => 'required|integer',
            'completed'        => 'nullable|boolean',
        ]);

        $history = WatchHistory::updateOrCreate(
            ['user_id' => 1, 'video_id' => $validated['video_id']],
            [
                'progress_seconds' => $validated['progress_seconds'],
                'completed'        => $validated['completed'] ?? false,
                'watched_at'       => now(),
            ]
        );

        return response()->json(['data' => $history], 200);
    }
}