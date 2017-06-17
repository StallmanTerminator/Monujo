# "THE BEER-WARE LICENSE" (Revision 42):
# d0p1 <d0p1@yahoo.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.

FPC		= fpc
LAZBUILD	= lazbuild
RM		= rm -f
MV		= mv

TARGET		= monujo
TEST_TARGET	= testmonujo

FPFLAGS		=  -Fu./src/

all: $(TARGET)

test: $(TEST_TARGET)
	./$<

$(TARGET):
	@echo "todo"

$(TEST_TARGET):
	$(FPC) test/testmonujo.pas $(FPFLAGS)
	$(MV) test/$@ $@

clean:
	$(RM) src/*.o
	$(RM) src/*.ppu

fclean: clean
	$(RM) $(TARGET)
	$(RM) $(TEST_TARGET)


re: fclean all

.PHONY: all clean fclean re test
