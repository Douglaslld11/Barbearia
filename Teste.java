package Barbearia;

import java.util.*;
public class Teste {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Barbearia minhaBarbearia = new Barbearia("Dg Barbearia", "Rua central 123");
		minhaBarbearia.apresentar();
		
		Scanner sc = new Scanner(System.in);
		
		System.out.println("Nome");
		String nome = sc.nextLine();
		
		System.out.println("Idade");
		int idade = sc.nextInt();
		sc.nextLine();
		
		System.out.println("Sexo");
		String sexo = sc.nextLine();
		
		boolean querCabelo = false;
		boolean querBarba = false;
		boolean querSobrancelha = false;
		
		int opcao;
		
		do {
			System.out.println("\n Quais serviços vai escolher?");
			System.out.println("1 - Cabelo");
			System.out.println("2 - Barba");
			System.out.println("3 - Sobrancelha");
			System.out.println("0 - Finalizar escolha");
			System.out.println("Digite sua escolha: ");
			opcao = sc.nextInt();
			
			switch (opcao) {
			case 1 -> querCabelo = true;
			case 2 -> querBarba = true;
			case 3 -> querSobrancelha = true;
			case 0 -> System.out.println("Finalizando escolha...");
			default -> System.out.println("Opção inválida");
			}
		} while (opcao != 0);
		
		Cliente cliente = new Cliente(nome, idade, sexo, querCabelo, querBarba, querSobrancelha);
		cliente.mostrarResumo();
		
		sc.close();
	}

}
