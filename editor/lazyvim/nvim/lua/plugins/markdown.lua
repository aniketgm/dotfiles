return {
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        -- bullets = { "१", "२", "३", "४", "५" },
        bullets = { "󰎤", "󰎧", "󰎪", "󰎭", "󰎱" },
        -- bullets = { "⬤ ", "⭘ ", "⯄ ", "⯂ ", "⯀ " },
        fat_headlines = false,
        headline_indent = false,
        headline_highlights = {
          -- "markdownH1", "markdownH2", "markdownH3", "markdownH4", "markdownH5", "markdownH6",
          "@comment.error",
          "@comment.note",
          "@comment.todo",
          "@comment.warning",
        },
      },
    },
    lazy = true,
    ft = "markdown",
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        { name = "personal", path = os.getenv("HOME") .. "/Documents/obsidiannotes/Personal" },
        { name = "work", path = os.getenv("HOME") .. "/Documents/obsidiannotes/Work" },
      },
      daily_notes = {
        folder = "Dailies",
        date_format = "%Y-%b-%d",
        template = os.getenv("HOME") .. "/Documents/obsidiannotes/Work/Templates/nvdaily.md",
      },
      templates = { folder = "Templates" },
      -- completion = { nvim_cmp = true },
      ui = {
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          -- Characters indicate the states -> Todo, InProgress, Done, Paused/OnHold,
          -- Note/Description/Context, HighImportance, AwaitingClarity, respectively
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["-"] = { char = "ﯰ", hl_group = "ObsidianPartial" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          ["|"] = { char = "ﰦ", hl_group = "ObsidianPaused" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          ["?"] = { char = "ﲉ", hl_group = "ObsidianQuestion" },
        },
        bullets = { char = "ﰲ", hl_group = "ObsidianBullet" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f78c6c" },
          ObsidianDone = { bold = true, fg = "#89ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5370" },
          ObsidianImportant = { bold = true, fg = "#d73128" },
          ObsidianBullet = { bold = true, fg = "#89ddff" },
          ObsidianRefText = { underline = true, fg = "#c792ea" },
          ObsidianExtLinkIcon = { fg = "#c792ea" },
          ObsidianTag = { italic = true, fg = "#89ddff" },
          ObsidianBlockID = { italic = true, fg = "#89ddff" },
          ObsidianHighlightText = { bg = "#75662e" },
          ObsidianQuestion = { bold = true, fg = "#ff5370" },
          ObsidianPartial = { bold = true, fg = "#c792ea" },
          ObsidianPaused = { bold = true, fg = "#f78c6c" },
        },
      },
    },
    keys = {
      { "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Show dailies" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find notes" },
      { "<leader>og", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      -- { "<leader>oh", "<cmd>FzfLua grep_curbuf search=#<cr>", desc = "Show current note headings" },
      { "<leader>oh", "<cmd>Telescope heading<cr>", desc = "Show current note headings" },
      {
        "<leader>oH",
        "<cmd>Telescope live_grep cwd=~/Documents/obsidiannotes/Work/ search=##<cr>",
        desc = "Show all notes headings",
      },
      { "<leader>ol", "<cmd>ObsidianFollowLink<cr>", desc = "Follow link" },
      { "<leader>on", mode = { "v" }, "<cmd>ObsidianLinkNew<cr>", "Add new link" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open obsidian gui" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Grep in notes" },
      { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Open todays note" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Switch workspace" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Open yesterdays note" },
    },
    lazy = true,
    ft = "markdown",
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n", "v" },
        { "<leader>o", group = "obsidian", icon = { icon = "🪨" } },
      },
    },
  },
}
