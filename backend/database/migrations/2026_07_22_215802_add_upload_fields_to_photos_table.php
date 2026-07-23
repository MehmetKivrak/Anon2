<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('photos', function (Blueprint $table) {
            $table->string('image_path')->nullable()->after('path');
            $table->string('original_filename')->nullable()->after('image_path');
            $table->string('mime_type')->nullable()->after('original_filename');
            $table->unsignedBigInteger('file_size')->nullable()->after('mime_type');
            $table->string('processing_status')->default('processed')->after('file_size');
            $table->string('album_number')->nullable()->after('processing_status');
        });
    }

    public function down(): void
    {
        Schema::table('photos', function (Blueprint $table) {
            $table->dropColumn(['image_path', 'original_filename', 'mime_type', 'file_size', 'processing_status', 'album_number']);
        });
    }
};