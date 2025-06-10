package Barbearia;

public class Cliente extends Pessoa {
	   private boolean querCabelo;
	   private boolean querBarba;
	   private boolean querSobrancelha;

	   public Cliente(String nome, int idade, String sexo, boolean querCabelo, boolean querBarba, boolean querSobrancelha) {
	    super(nome, idade, sexo);
	    this.querCabelo = querCabelo;
	    this.querBarba = querBarba;
	    this.querSobrancelha = querSobrancelha;
	   }
	   
	   public double calcularTotal() {
	    double total = 0;
	    if(this.querCabelo) {
	        total += 35;
	    }
	    if(this.querBarba) {
	        total += 30;
	    }
	    if(this.querSobrancelha) {
	        total += 20;
	    }
	    return total; 
	   }

	   public void mostrarResumo() {
	    System.out.println("Cliente: " + getNome());
	    System.out.println("Serviços selecionados");
	    if(querCabelo) System.out.println("-Cabelo");
	    if(querBarba) System.out.println("-Barba");
	    if(querSobrancelha) System.out.println("-Sobrancelha");
	    System.out.println("Total a pagar: $" + calcularTotal());
	   }
}
