#include <stdio.h>
#include <stdbool.h>
bool checkWin(char board[3][3], char player);
void printBoard(char board[3][3]);
int main()
{
    printf("Welcome to Tic Tac Toe! \n");
    char board[3][3] = {{'1', '2', '3'}, {'4', '5', '6'}, {'7', '8', '9'}};
    for (int k = 0; k < 9; k++)
    {
        printBoard(board);
        char position, player = k % 2 == 0 ? 'x' : 'o';
        printf("Enter the Position Number, Player %c Turn \n", player);
        scanf(" %c", &position);
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {
                if (board[i][j] == position)
                {
                    board[i][j] = player;
                }
            }
        }
        if (checkWin(board, player))
        {
            printBoard(board);
            printf("%c won! \n", player);
            return 0;
        }
    }
    printf("Draw! \n");
    return 0;
}
bool checkWin(char board[3][3], char player)
{
    bool win;
    for (int i = 0; i < 3; i++)
    {
        win = win || (board[i][0] == player && board[i][1] == player && board[i][2] == player);
        win = win || (board[0][i] == player && board[1][i] == player && board[2][i] == player);
    }
    win = win || (board[0][0] == player && board[1][1] == player && board[2][2] == player);
    win = win || (board[0][2] == player && board[1][1] == player && board[2][0] == player);
    return win;
}
void printBoard(char board[3][3])
{
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            printf("%c ", board[i][j]);
        }
        printf("\n");
    }
}
