<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class TaskController extends Controller
{
    public function index()
{
    $tasks = Cache::remember('tasks_all', 60, function () {
        return Task::all()->toArray();
    });
    return response()->json(['success' => true, 'data' => $tasks], 200);
}

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title'       => 'required|string|max:255',
            'description' => 'nullable|string',
            'status'      => 'nullable|string',
        ]);
        $task = Task::create($validated);
        Cache::forget('tasks_all');
        return response()->json(['success' => true, 'data' => $task], 201);
    }

    public function show($id)
    {
        $task = Task::findOrFail($id);
        return response()->json(['success' => true, 'data' => $task], 200);
    }

    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);
        $validated = $request->validate([
            'title'       => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'status'      => 'nullable|string',
        ]);
        $task->update($validated);
        Cache::forget('tasks_all');
        return response()->json(['success' => true, 'data' => $task], 200);
    }

    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $task->delete();
        Cache::forget('tasks_all');
        return response()->json(null, 204);
    }
}