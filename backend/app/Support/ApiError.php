<?php

namespace App\Support;

class ApiError
{
    public static function response(string $message, int $statusCode, array $errors = [])
    {
        $body = ['success' => false, 'message' => $message];
        if (!empty($errors)) {
            $body['errors'] = $errors;
        }
        return response()->json($body, $statusCode);
    }
}