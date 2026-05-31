<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\Api\FollowController;
use App\Http\Controllers\Api\FeedController;
use App\Http\Controllers\Api\VideoController;
use App\Http\Controllers\Api\RecommendationController;
use App\Http\Controllers\Api\WatchHistoryController;
use App\Http\Controllers\Api\WatchlistController;
$studentId = '78883';

Route::prefix($studentId . '/v1')->group(function () {
        
    Route::get('/tasks', [TaskController::class, 'index']);
    Route::post('/tasks', [TaskController::class, 'store']);
    Route::get('/tasks/{id}', [TaskController::class, 'show']);
    Route::put('/tasks/{id}', [TaskController::class, 'update']);
    Route::patch('/tasks/{id}', [TaskController::class, 'update']);
    Route::delete('/tasks/{id}', [TaskController::class, 'destroy']);
    Route::post('users/{id}/follow', [FollowController::class, 'follow']);
    Route::delete('users/{id}/follow', [FollowController::class, 'unfollow']);
    Route::get('feed', [FeedController::class, 'index']);
    // Videos
Route::get('videos', [VideoController::class, 'index']);
Route::get('videos/{id}', [VideoController::class, 'show']);
Route::post('videos', [VideoController::class, 'store']);

// Recommendations
Route::get('recommendations', [RecommendationController::class, 'index']);

// Continue Watching
Route::get('continue-watching', [WatchHistoryController::class, 'continueWatching']);
Route::post('watch-history', [WatchHistoryController::class, 'store']);

// Watchlist
Route::get('watchlist', [WatchlistController::class, 'index']);
Route::post('watchlist', [WatchlistController::class, 'store']);
Route::delete('watchlist/{videoId}', [WatchlistController::class, 'destroy']);
});

Route::get('/health', function () {
    return response()->json(['status' => 'ok']);
});