<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\Api\FollowController;
use App\Http\Controllers\Api\FeedController;

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
});

Route::get('/health', function () {
    return response()->json(['status' => 'ok']);
});