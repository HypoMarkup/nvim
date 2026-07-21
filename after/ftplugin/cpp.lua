-- Remove the blanket ':' trigger that reindents on every colon. This prevents
-- the first ':' in '::' (scope resolution) from dedenting the line.
vim.opt_local.cinkeys:remove(":")
vim.opt_local.indentkeys:remove(":")

-- Re-add targeted triggers so scope declarations and 'default:' still
-- auto-indent when you finish typing them. 'case VALUE:' won't auto-indent
-- on ':' (the value between 'case' and ':' varies), but it still gets
-- correct indent on Enter or '=='.
vim.opt_local.cinkeys:append("0=public:,0=private:,0=protected:,0=default:")
vim.opt_local.indentkeys:append("0=public:,0=private:,0=protected:,0=default:")
