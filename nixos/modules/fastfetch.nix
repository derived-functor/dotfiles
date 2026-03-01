{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "kitty";
        source = "/home/mreblan/.config/fastfetch/logo.png";
        width = 30;
        padding = {
          top = 5;
          left = 2;
        };
      };

      key = {
        width = 17;
      };

      display = {
        separator = " || ";
        color = {
          title = "#cba6f7";
          keys = "#94e2d5";
        };
      };

      modules = [
        {
          type = "title";
          format = "{user-name-colored}@{host-name-colored}";
        }
        {
          type = "separator";
          string = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━";
        }
        {
          type = "os";
          key = "󰣇 OS ";
          keyColor = "#94e2d5";
        }
        {
          type = "host";
          key = "󰌢 HT ";
          keyColor = "#94e2d5";
        }
        {
          type = "kernel";
          key = " KR ";
          keyColor = "#94e2d5";
        }
        {
          type = "shell";
          key = " SH ";
          keyColor = "#94e2d5";
        }
        {
          type = "wm";
          key = " WM ";
          keyColor = "#94e2d5";
        }
        {
          type = "terminal";
          key = " TR ";
          keyColor = "#94e2d5";
        }
        {
          type = "cpu";
          key = " CP ";
          keyColor = "#94e2d5";
        }
        {
          type = "gpu";
          key = "󰢮 GP ";
          keyColor = "#94e2d5";
        }
        {
          type = "memory";
          key = " RAM";
          keyColor = "#94e2d5";
        }
        {
          type = "disk";
          key = "  /     ";
          folders = "/";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "disk";
          key = "  /home ";
          folders = "/home";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        "break"
        {
          type = "colors";
          symbol = "square";
        }
      ];
    };
  };
}
