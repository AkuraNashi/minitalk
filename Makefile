# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lcamilo- <lcamilo-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/11 16:47:09 by lcamilo-          #+#    #+#              #
#    Updated: 2022/10/19 20:35:17 by lcamilo-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# ------------  COLORS  ------------------------------------------------------ #
COLOUR_GREEN=\033[0;32m
COLOUR_RED=\033[0;31m
COLOUR_ORANGE=\033[0;34m
COLOUR_END=\033[0m
COLOUR_YELLOW=\033[0;33m
COLOUR_CYAN=\033[0;36m

# ------------  PROJECT  ----------------------------------------------------- #
CLIENT		= client
SERVER		= server

# ------------  DIRECTORIES  ------------------------------------------------- #
LIB			= libftprintfgnl
SRC_PATH	= ./
HEADERS		= incl

# ------------  FLAGS  ------------------------------------------------------- #
CFLAGS 		= -Wall -Wextra -Werror
CC			= @cc
RM			=	rm -rf

# ------------  SOURCE FILES  ------------------------------------------------ #
SRC 		= 	client.c						\
				serveur.c

# ------------  FILEPATHS  --------------------------------------------------- #
SRCS 		= $(addprefix $(SRC_PATH),$(SRC))
OBJS		= ${SRCS:.c=.o}

all: lib $(SERVER) $(CLIENT)

lib:
			@echo "$(COLOUR_CYAN)Compilation libft..."
			make -C $(LIB)
			@echo "$(COLOUR_YELLOW)Deplacement du libft.a $(COLOUR_END)"
			@echo "$(COLOUR_GREEN)"cp ./libftprintfgnl/libft.a libft.a
			@echo "$(COLOUR_END)"

$(SERVER): $(OBJS)
			@echo "$(COLOUR_CYAN)Compile serveur"
			$(CC) $(CFLAGS)  -I libftprintfgnl/includes  -o $@ serveur.o -L libftprintfgnl -lft
			@echo "$(COLOUR_RED)Serveur ready."

$(CLIENT): $(OBJS)
			@echo "$(COLOUR_CYAN)Compile client"
			$(CC) $(CFLAGS)  -I libftprintfgnl/includes  -o $@ client.o -L libftprintfgnl -lft
			@echo "$(COLOUR_ORANGE)Client ready."

%.o: %.c
		${CC} $(CFLAGS) -I$(HEADERS) -I$(LIB) -c $< -o $@ -g3

clean:
			$(RM) ${OBJS}
			make fclean -C $(LIB)

fclean:		clean
			$(RM) $(CLIENT) $(SERVER) *.a

re:			fclean all

.PHONY: re ignore fclean clean all $(LIBFT) $(NAME) $(PRINTF)