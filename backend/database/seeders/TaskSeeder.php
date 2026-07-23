<?php

namespace Database\Seeders;

use App\Models\Task;
use Illuminate\Database\Seeder;

class TaskSeeder extends Seeder
{
    public function run(): void
    {
        $tasks = [
            ['title' => 'Setup Laravel project',   'description' => 'Initialize backend structure',      'status' => 'done'],
            ['title' => 'Configure PostgreSQL',    'description' => 'Connect Laravel to PostgreSQL',      'status' => 'done'],
            ['title' => 'Implement Task CRUD',     'description' => 'Build REST endpoints for tasks',     'status' => 'done'],
            ['title' => 'Add Redis caching',       'description' => 'Cache task list with cache-aside',   'status' => 'in_progress'],
            ['title' => 'Write session 4 report',  'description' => 'Document Docker + Redis deployment', 'status' => 'todo'],
        ];

        foreach ($tasks as $task) {
            Task::firstOrCreate(['title' => $task['title']], $task);
        }
    }
}