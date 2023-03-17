defmodule Encoding do
  def generate_map({:node, :na, tree_left, tree_right}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    generate_map(tree_right, map, current_path <> ".")
  end
  def generate_map({:node, character, :nil, :nil}, map, current_path) do
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, tree_left, :nil}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, :nil, tree_right}, map, current_path) do
    map = generate_map(tree_right, map, current_path <> ".")
    Map.put(map, [character], current_path)
  end
  def generate_map({:node, character, tree_left, tree_right}, map, current_path) do
    map = generate_map(tree_left, map, current_path <> "-")
    map = generate_map(tree_right, map, current_path <> ".")
    Map.put(map, [character], current_path)
  end
  def generate_map(_, map, _) do map end


  def encode(str) do
    morse_tree = morse()
    map = generate_map(morse_tree, %{}, "")
    encoder(map, str, "")
  end
  def encoder(_, [], result) do result end
  def encoder(map, [head | tail], result) do
    case Map.get(map, [head]) do
      nil ->
        encoder(map, tail, result)
      char ->
        encoder(map, tail, result <> " " <> char)
    end
  end
  def morse() do
    {:node, :na,
    {:node, 116,
        {:node, 109,
        {:node, 111,
            {:node, :na,
            {:node, 48, nil, nil},
            {:node, 57, nil, nil}
            },
            {:node, :na,
            nil,
            {:node, 56, nil,
                {:node, 58, nil, nil}
            }
            }
        },
        {:node, 103,
            {:node, 113, nil, nil},
            {:node, 122,
            {:node, :na,
                {:node, 44, nil, nil},
                nil
            },
            {:node, 55, nil, nil}
            }
        }
        },
        {:node, 110,
        {:node, 107,
            {:node, 121, nil, nil},
            {:node, 99, nil, nil}
        },
        {:node, 100,
            {:node, 120, nil, nil},
            {:node, 98, nil,
            {:node, 54,
                {:node, 45, nil, nil},
                nil
            }
            }
        }
        }
    },
    {:node, 101,
        {:node, 97,
        {:node, 119,
            {:node, 106,
            {:node, 49,
                {:node, 47, nil, nil},
                {:node, 61, nil, nil}
            },
            nil
            },
            {:node, 112,
            {:node, :na,
                {:node, 37, nil, nil},
                {:node, 64, nil, nil}
            },
            nil
            }
        },
        {:node, 114,
            {:node, :na,
            nil,
            {:node, :na,
                {:node, 46, nil, nil},
                nil
            }
            },
            {:node, 108, nil, nil}
        }
        },
        {:node, 105,
        {:node, 117,
            {:node, 32,
            {:node, 50, nil, nil},
            {:node, :na,
                nil,
                {:node, 63, nil, nil}
            }
            },
            {:node, 102, nil, nil}
        },
        {:node, 115,
            {:node, 118,
            {:node, 51, nil, nil},
            nil
            },
            {:node, 104,
            {:node, 52, nil, nil},
            {:node, 53, nil, nil}
            }
        }
        }
    }
    }

    end
end