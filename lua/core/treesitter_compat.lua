-- ============================================================================
-- TREE-SITTER COMPATIBILITY SHIM (Neovim 0.12+ support for plugins on master)
-- ============================================================================
-- In Neovim 0.12+, Tree-sitter query captures are passed as table<integer, TSNode[]>
-- (arrays of nodes) to support quantified captures.
-- Plugins expecting legacy single TSNode captures fail when calling node:range()
-- or passing arrays to vim.treesitter.get_node_text / get_range.
-- This module unwraps arrays transparently without breaking native 0.12 behaviors.

local M = {}

local function unwrap_node(node)
  if type(node) == "table" and not (node.range or (getmetatable(node) and getmetatable(node).range)) then
    return node[1] or node[#node]
  end
  return node
end

function M.setup()
  if not vim.treesitter then
    return
  end

  -- 1. Shim vim.treesitter.get_node_text
  local orig_get_node_text = vim.treesitter.get_node_text
  if orig_get_node_text then
    vim.treesitter.get_node_text = function(node, source, opts)
      node = unwrap_node(node)
      if not node then
        return ""
      end
      return orig_get_node_text(node, source, opts)
    end
  end

  -- 2. Shim vim.treesitter.get_range
  local orig_get_range = vim.treesitter.get_range
  if orig_get_range then
    vim.treesitter.get_range = function(node, source, metadata)
      node = unwrap_node(node)
      if not node then
        return { 0, 0, 0, 0 }
      end
      return orig_get_range(node, source, metadata)
    end
  end

  -- 3. Shim query directive and predicate registration
  if vim.treesitter.query then
    local orig_add_directive = vim.treesitter.query.add_directive
    if orig_add_directive then
      vim.treesitter.query.add_directive = function(name, handler, opts)
        local wrapped_handler = function(match, pattern, source, pred, metadata)
          local safe_match = setmetatable({}, {
            __index = function(_, k)
              return unwrap_node(match[k])
            end,
            __newindex = function(_, k, v)
              match[k] = v
            end,
            __pairs = function(_)
              return pairs(match)
            end,
          })
          return handler(safe_match, pattern, source, pred, metadata)
        end
        return orig_add_directive(name, wrapped_handler, opts)
      end
    end

    local orig_add_predicate = vim.treesitter.query.add_predicate
    if orig_add_predicate then
      vim.treesitter.query.add_predicate = function(name, handler, opts)
        local wrapped_handler = function(match, pattern, source, pred)
          local safe_match = setmetatable({}, {
            __index = function(_, k)
              return unwrap_node(match[k])
            end,
            __newindex = function(_, k, v)
              match[k] = v
            end,
            __pairs = function(_)
              return pairs(match)
            end,
          })
          return handler(safe_match, pattern, source, pred)
        end
        return orig_add_predicate(name, wrapped_handler, opts)
      end
    end
  end
end

M.setup()

return M
