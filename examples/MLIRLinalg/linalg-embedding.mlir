// TODO: A simple embeddingbag, similar to Torch-EmbeddingBag

func.func @embedding_bag_layer(%input: tensor<?x?xi32>, %offsets: tensor<?xi32>, %embedding_weights: tensor<?x?xf32>) -> tensor<?x?xf32> {
  // EmbeddingBag operation will be implemented here
}

%result = linalg.generic
  ins(%embedding_weights, %input, %offsets : tensor<?x?xf32>, tensor<?x?xi32>, tensor<?xi32>)
  outs(%output : tensor<?x?xf32>)
  indexing_maps = [
    affine_map<(d0, d1, d2) -> (d0, d1)>,
    affine_map<(d0, d1, d2) -> (d2)>,
    affine_map<(d0, d1, d2) -> (d1)>
  ]
  iterator_types = ["parallel", "reduction", "parallel"]
  body = [{
    ^bb0(%a: f32, %b: f32, %c: f32):
      %sum = addf %a, %b : f32
      linalg.yield %sum : f32
  }]

  %lengths = linalg.generic
  ins(%offsets : tensor<?xi32>)
  outs(%lengths_out : tensor<?xi32>)
  indexing_maps = [
    affine_map<(d0) -> (d0)>,
    affine_map<(d0) -> (d0)>
  ]
  iterator_types = ["parallel"]
  body = [{
    ^bb0(%a: i32, %b: i32):
      %diff = subi %a, %b : i32
      linalg.yield %diff : i32
  }]

  %normalized = linalg.generic
  ins(%result, %lengths : tensor<?x?xf32>, tensor<?xi32>)
  outs(%normalized_out : tensor<?x?xf32>)
  indexing_maps = [
    affine_map<(d0, d1) -> (d0, d1)>,
    affine_map<(d0, d1) -> (d0)>,
    affine_map<(d0, d1) -> (d0, d1)>
  ]
  iterator_types = ["parallel", "parallel"]
  body = [{
    ^bb0(%a: f32, %b: i32, %c: f32):
      %div = divf %a, %b : f32
      linalg.yield %div : f32
  }]

  return %normalized : tensor<?x?xf32>
