SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
CAROOT=$(shell pwd)/dev/certs
TMUX_SESSION_NAME := sunulator

export SUNULATOR_DOMAIN_NAME := sunulator.hack
# export SUNULATOR_POSTGRES_HOSTNAME := 127.0.0.1
# export SUNULATOR_POSTGRES_USERNAME := postgres
# export SUNULATOR_POSTGRES_PASSWORD :=

# Import and export the contents of .env (if present)
-include .env

dev/certs/$(SUNULATOR_DOMAIN_NAME).pem:
	cd dev/certs && mkcert $(subst .pem,,$(notdir $@))

# Bootstrap the project for local development
bootstrap: dev/certs/$(SUNULATOR_DOMAIN_NAME).pem
	$(MAKE) -C umbrella $@
	@echo ""
	@echo "Everything is awesome! 💖"

# Start the local development stack
up:
	@tmux start-server
	@tmux kill-session -t $(TMUX_SESSION_NAME) || true
	@tmux new-session -d -s $(TMUX_SESSION_NAME) -x "$(shell tput cols)" -y "$(shell tput lines)" $(SHELL)
	@tmux split-window -d -t $(TMUX_SESSION_NAME):0.0 -p 20 -v $(SHELL)
	@tmux split-window -d -t $(TMUX_SESSION_NAME):0.0 -p 50 -h $(SHELL)
	@tmux set-option -t $(TMUX_SESSION_NAME) -g set-titles on
	@tmux set-option -t $(TMUX_SESSION_NAME) -g mouse on
	@tmux set-option -t $(TMUX_SESSION_NAME) -g default-terminal "screen-256color"
	@tmux set-option -t $(TMUX_SESSION_NAME) -g visual-activity on
	@tmux set-option -t $(TMUX_SESSION_NAME) -g pane-border-format " #{pane_index}: #{pane_title} "
	@tmux set-option -t $(TMUX_SESSION_NAME) -g aggressive-resize on
	@tmux set-window-option -t $(TMUX_SESSION_NAME) -g automatic-rename off
	@tmux set-window-option -t $(TMUX_SESSION_NAME) -g monitor-activity on
	@tmux set-window-option -t $(TMUX_SESSION_NAME) -g pane-border-status top
	@tmux select-pane -t $(TMUX_SESSION_NAME):0.0 -T "Backend"
	@tmux send-keys -t $(TMUX_SESSION_NAME):0.0 "$(MAKE) up.app" C-m
	@tmux select-pane -t $(TMUX_SESSION_NAME):0.1 -T "Assets"
	@tmux send-keys -t $(TMUX_SESSION_NAME):0.1 "$(MAKE) up.assets" C-m
	@tmux select-pane -t $(TMUX_SESSION_NAME):0.2 -T "Nginx"
	@tmux send-keys -t $(TMUX_SESSION_NAME):0.2 "$(MAKE) up.nginx" C-m
	@tmux set-window-option -t $(TMUX_SESSION_NAME) -g synchronize-panes off
	@tmux attach-session -t $(TMUX_SESSION_NAME)

up.nginx:
	@nginx -p "$(shell pwd)" -c dev/nginx/$(SUNULATOR_DOMAIN_NAME).conf -s stop || true
	nginx -p "$(shell pwd)" -c dev/nginx/$(SUNULATOR_DOMAIN_NAME).conf -g "daemon off;"

up.app:
	$(MAKE) -C umbrella up

up.assets:
	$(MAKE) -C umbrella up.assets

down:
	@tmux kill-session -t $(TMUX_SESSION_NAME)
	@echo ""
	@echo "Bye! 👋🏼"
