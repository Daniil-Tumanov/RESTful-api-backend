<?php

namespace App\Http\Controllers\rest;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\RestModel;
use App\Models\CommentModel;
use Validator;

class restController extends Controller
{
    public function dishes(){
        return response()->json(['status code' => 200,'status text' => 'List dishes','Dishes' => RestModel::get()], 200);
    }

    public function dishById($id){
        $dishes = RestModel::find($id);
        $comments = CommentModel::where('id', $id)->get();
        if(is_null($dishes)){
            return response()->json(['status code' => 404, 'status text' => 'Dish not found', 'message' => 'Dish not found'], 404);
        }
        return response()->json(['status code'=> 200, 'status text'=>'View dish', 'Dish' => $dishes, 'Comment' => $comments], 200);
    }

    public function addDish(Request $req){
        $rules = [
            'title' => 'required|unique:dishes|min:2',
            'description' => 'required|min:2',
            'composition' => 'required|min:2',
            'cost' => 'required|integer',
            'img' => 'required|image|mimes:jpg,jpeg,png|max:2048'
        ];
        $validator = Validator::make($req->all(), $rules);
        if($validator->fails()){
            return response()->json($validator->errors(), 400);
        }

        if ($req->hasFile('img')) {
            $image = $req->file('img');
            $name = $image->getClientOriginalName();                    
            $destinationPath = public_path('/dishes_images');
            $image->move($destinationPath, $name);

            $dishes = new RestModel();
            $dishes->title = $req->title;
            $dishes->description = $req->description;
            $dishes->composition = $req->composition;
            $dishes->cost = $req->cost;
            $dishes->tags = $req->tags;
            $dishes->img = $name;

            $dishes->save();
        }   
        return response()->json(['status code' => 201, 'status text' => 'Successful creation', 'status' => 'true', 'dish_id'=> $dishes->id], 201);
    }

    public function editDish(Request $req, $id){
        $dishes = RestModel::find($id);
        if(is_null($dishes)){
            return response()->json(['status code' => 400, 'status text' => 'Editing error', 'status' => 'false', 'message' => 'Dish not found'], 404);
        }
        if ($req->hasFile('img')) {
            $image = $req->file('img');
            $name = $image->getClientOriginalName();                    
            $destinationPath = public_path('/dishes_images');
            $image->move($destinationPath, $name);

            $dishes->img = $name;

            $dishes->save();
            
        }   
        $dishes->where('id', $id)->update($req->all());
        return response()->json(['status code' => 201, 'status text:'=>'Successful editing', 'Dish' => RestModel::find($id)], 201);
    }

    public function deleteDish($id){
        $dishes = RestModel::find($id);
        if(is_null($dishes)){
            return response()->json(['status code' => 404, 'status text' => 'Dish not found', 'message' => 'Dish not found'], 404);
        }
        $dishes->where('id', $id)->delete();
        return response()->json(['status code' => 201,'status text' => 'Successful delete', 'status' => true], 201);
    }

    public function searchByTag($tag){
        $search = RestModel::where('tags', 'like', "%{$tag}%")->get();
        if($search->isEmpty()){
        return response()->json(['status code' => 404,'status text' => 'Tags not found'], 404);
        }
        return response()->json(['status code' => 200,'status text' => 'Found dishes', 'dishes' => $search], 200);
    }

    public function postComment(Request $req, $id){
        $dishes = RestModel::find($id);
        if(is_null($dishes)){
            return response()->json(['status code' => 404, 'status text' => 'Dish not found', 'message' => 'Dish not found'], 404);
        }
        $rules = [
            'author' => 'required',
            'comment' => 'required|min:3|max:255'
        ];
        $validator = Validator::make($req->all(), $rules);
        if($validator->fails()){
            return response()->json($validator->errors(), 400);
        }
        $comment = CommentModel::create([
        'author' => $req->author,
        'comment' => $req->comment,
        'id' => $id
        ]);

        $comment->save();

        return response()->json(['status code' => 201, 'status text:'=>'Successful creation', 'status' => 'true'], 201);
    }
    
    public function deleteComment($id, $id_comment){
        $dishes = RestModel::find($id);
        if(is_null($dishes)){
            return response()->json(['status code' => 404, 'status text' => 'Dish not found', 'message' => 'Dish not found'], 404);
        }
        $comment = CommentModel::select('id_comment')->from('comments')->where('id_comment', $id_comment)->get();
        
        if($comment->isEmpty()){
            return response()->json(['status code' => 404, 'status text' => 'Comment not found', 'message' => 'Comment not found'], 404);
        }
        $comment = CommentModel::where('ID_comment', $id_comment)->delete();
        return response()->json(['status code' => 201,'status text' => 'Successful delete', 'status' => true], 201);
    }
    }