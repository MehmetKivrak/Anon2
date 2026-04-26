<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TaskController;

$studentId = '78883'; // ← KENDİ NUMARAN

Route::prefix($studentId . '/v1')->group(function () {
    Route::get('/tasks', [TaskController::class, 'index']);
    Route::post('/tasks', [TaskController::class, 'store']);
    Route::get('/tasks/{id}', [TaskController::class, 'show']);
    Route::put('/tasks/{id}', [TaskController::class, 'update']);
    Route::patch('/tasks/{id}', [TaskController::class, 'update']);
    Route::delete('/tasks/{id}', [TaskController::class, 'destroy']);
});

Route::get('/health', function () {
    return response()->json(['status' => 'ok']);
});