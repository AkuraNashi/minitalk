/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lcamilo- <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/12/08 00:19:56 by lcamilo-          #+#    #+#             */
/*   Updated: 2022/12/08 00:19:57 by lcamilo-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"
//SIGUSR1 = envoie
//SIGUSR2 = recoit
void	char_to_bin(char c, int pid)
{
	int	bit;

	bit = 0;
	while (bit < 8)
	{
		if (c & 128)
		{
			if (kill(pid, SIGUSR2) == -1)
				ft_printf("Error...\n");
		}
		else
		{
			if (kill(pid, SIGUSR1) == -1)
				ft_printf("Error...\n");
		}
		c <<= 1;
		bit++;
		pause();
		usleep(100);
	}
}

void	recieved(int sig)
{
	static int	sent;

	if (sig == SIGUSR1)
	{
		ft_printf("Signal sent successfully!\n");
		exit(EXIT_SUCCESS);
	}
	if (sig == SIGUSR2)
		++sent;
}

void	send_message(char *str, int pid)
{
	int	i;

	 i = 0;
	 while (str[i])
		 char_to_bin(str[i++], pid);
	 char_to_bin('\0', pid);
}
//TODO Envoyer signal a pid serveur
int	main(int ac, char **av)
{
	int	client_pid;
	int serv_pid;

	ft_strlen("test");
	if (ac == 3)
	{
		client_pid = getpid();
		ft_printf("Mon pid : [%d]\n", client_pid);
		signal(SIGUSR1, recieved);
		signal(SIGUSR2, recieved);
		serv_pid = ft_atoi(av[1]);
		send_message(av[2], serv_pid);
	}
	else
		ft_printf("Usage : ./client PID MSG\n");
	return (EXIT_FAILURE);
}
