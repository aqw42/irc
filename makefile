SERVER = ./server
CLIENT = ./client

SRC_NAME_SERVER =	main.c\
					fd_socket.c\
					init_socket.c\
					loop.c
DIR_SERVER = ./sources/server/
SRC_SERVER = ${addprefix $(DIR_SERVER), $(SRC_NAME_SERVER)}
OBJ_SERVER = ${addprefix $(OBJDIR), $(SRC_NAME_SERVER:.c=.o)}

SRC_NAME_CLIENT = main.c
DIR_CLIENT =  ./sources/client/
SRC_CLIENT = ${addprefix $(DIR_CLIENT), $(SRC_NAME_CLIENT)}
OBJ_CLIENT = ${addprefix $(OBJDIR), $(SRC_NAME_CLIENT:.c=.o)}

OBJDIR = ./objects/

HEADER_DIR = ./includes/
LIB_HEADER_DIR = ./haflib/includes/haflib.h

LIB = haflib/haflib.a
LIB_DIR = haflib

CC = clang
FLAGS = -Weverything -g3 -fsanitize=address

all: $(SERVER) #$(CLIENT)

$(SERVER): $(OBJDIR) $(LIB) $(OBJ_SERVER)
	$(CC) $(FLAGS) $(OBJ_SERVER) -o $(SERVER) -I $(HEADER_DIR) -I $(LIB_HEADER_DIR) $(LIB)

$(CLIENT): $(OBJDIR) $(LIB) $(OBJ_CLIENT)
	$(CC) $(FLAGS) $(OBJ_CLIENT) -o $(CLIENT) -I $(HEADER_DIR) -I $(LIB_HEADER_DIR) $(LIB)

$(OBJDIR)%.o : $(DIR_SERVER)%.c
	$(CC) $(FLAGS) -c $< -o $@ -I $(HEADER_DIR) -I $(LIB_HEADER_DIR)
	#echo "<$@>\c"

$(OBJDIR)%.o : $(DIR_CLIENT)%.c
	$(CC) $(FLAGS) -c $< -o $@ -I $(HEADER_DIR) -I $(LIB_HEADER_DIR)
	#echo "<$@>\c"

$(LIB):
	make -C $(LIB_DIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

re: fclean all

clean:
	rm -rf $(OBJ_SERVER) $(OBJ_CLIENT)

fclean: clean
	rm -f $(SERVER) $(CLIENT)

.PHONY: all re server client clean fclean
#.SILENT:
#.SUFFIXES: