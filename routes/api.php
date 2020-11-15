<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('dishes', 'rest\restController@dishes');
Route::get('dishes/{id}', 'rest\restController@dishById');

Route::post('dishes', 'rest\restController@addDish');
Route::post('dishes/{id}', 'rest\restController@editDish');
Route::delete('dishes/{id}', 'rest\restController@deleteDish');
Route::get('dishes/tags/{tags}', 'rest\restController@searchByTag');

Route::post('dishes/{id}/comments', 'rest\restController@postComment');
Route::delete('dishes/{id}/comments/{id_comment}', 'rest\restController@deleteComment');