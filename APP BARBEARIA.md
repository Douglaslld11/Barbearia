package Inicio;

import java.time.LocalTime;

public class Barbearia {
	private String nomeBarbearia;
	private String endereco;
	private String celular;
	private LocalTime abertura;
	private LocalTime fechamento;
	
	public Barbearia(String nomeBarbearia, String endereco, String celular, LocalTime abertura,
			LocalTime fechamento) {
		this.nomeBarbearia = nomeBarbearia;
		this.endereco = endereco;
		this.celular = celular;
		this.abertura = abertura;
		this.fechamento = fechamento;
		
	}
	
	public String getNomeBarbearia() {
		return this.nomeBarbearia;
	}
	
	public void setNomeBarbearia(String nomeBarbearia) {
		this.nomeBarbearia = nomeBarbearia;
	}
	
	public String getEndereco() {
		return this.endereco;
	}
	
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	
	public String getCelular() {
		return this.celular;
	}
	
	public void setCelular(String celular) {
		this.celular = celular;
	}
	
	public LocalTime getAbertura() {
		return this.abertura;
	}
	
	public LocalTime getFechamento() {
		return this.fechamento;
	}
	
	public boolean dentroDoHorario(LocalTime horario) {
		return !horario.isBefore(abertura) && !horario.isAfter(fechamento);
	}
}
