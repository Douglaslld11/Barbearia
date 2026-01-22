package Inicio;

public class Cliente {
	private String nomeCliente;
	private byte idade;
	private String celular;
	
	public Cliente(String nomeCliente, byte idade, String celular) {
		this.nomeCliente = nomeCliente;
		this.idade = idade;
		this.celular = celular;
	}
	
	public String getNomeCliente() {
		return this.nomeCliente;
	}
	
	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}
	
	public byte getIdade() {
		return this.idade;
	}
	
	public void setIdade(byte idade) {
		if(idade > 0 && idade < 127) {
			this.idade = idade;
		} else {
			System.out.println("Idade inválida");
		}
	}
	
	public String getCelular() {
		return this.celular;
	}
	
	public void setCelular(String celular) {
		this.celular = celular;
	}
}
