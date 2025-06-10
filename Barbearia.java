package Barbearia;

public class Barbearia {
	 private String nome;
	    private String endereco;
	 
	    public Barbearia(String nome, String endereco) {
	        this.nome = nome;
	        this.endereco = endereco;
	    }

	    public String getNome() {
	        return this.nome;
	    }

	    public void setNome(String nome) {
	        this.nome = nome;
	    }

	    public String getEndereco() {
	        return this.endereco;
	    }

	    public void setEndereco(String endereco) {
	        this.endereco = endereco;
	    }

	    public void apresentar() {
	        System.out.println("Bem vindo a barbearia " + this.nome + "!");
	        System.out.println("Endereço: " + this.endereco);
	        System.out.println();
	    }
}
