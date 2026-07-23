<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Photo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;

class PhotoController extends Controller
{
    public function index()
    {
        $photos = Cache::remember('photos.index', 60, function () {
            return Photo::all()->map(function ($photo) {
                $data = $photo->toArray();
                $data['image_url'] = $photo->image_path ? Storage::url($photo->image_path) : null;
                return $data;
            })->toArray();
        });

        return response()->json(['success' => true, 'data' => $photos], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id'      => 'required|integer',
            'caption'      => 'nullable|string',
            'album_number' => 'required|string',
            'image'        => 'required|image|max:5120',
        ]);

        $file = $request->file('image');
        $storedPath = $file->store('photos', 'public');

        $photo = Photo::create([
            'user_id'           => $validated['user_id'],
            'filename'          => basename($storedPath),
            'path'              => $storedPath,
            'caption'           => $validated['caption'] ?? null,
            'image_path'        => $storedPath,
            'original_filename' => $file->getClientOriginalName(),
            'mime_type'         => $file->getClientMimeType(),
            'file_size'         => $file->getSize(),
            'processing_status' => 'processed',
            'album_number'      => $validated['album_number'],
        ]);

        $photo->image_url = Storage::url($photo->image_path);

        Cache::forget('photos.index');

        return response()->json(['success' => true, 'data' => $photo], 201);
    }

    public function show($id)
    {
        $photo = Photo::findOrFail($id);
        $photo->image_url = $photo->image_path ? Storage::url($photo->image_path) : null;

        return response()->json(['success' => true, 'data' => $photo], 200);
    }

    public function destroy($id)
    {
        $photo = Photo::findOrFail($id);

        if ($photo->image_path) {
            Storage::disk('public')->delete($photo->image_path);
        }

        $photo->delete();
        Cache::forget('photos.index');

        return response()->json(null, 204);
    }
}