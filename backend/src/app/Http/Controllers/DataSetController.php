<?php

namespace App\Http\Controllers;

use App\Models\DataSet;
use Illuminate\Http\Request;

class DataSetController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $koneksi = DataSet::get();
        // $koneksi = DataSet::limit(1600)->get();
        return response()->json($koneksi, 200);
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(DataSet $dataSet)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(DataSet $dataSet)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, DataSet $dataSet)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(DataSet $dataSet)
    {
        //
    }
}
