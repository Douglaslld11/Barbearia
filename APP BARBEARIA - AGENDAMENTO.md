package Inicio;

import java.time.LocalTime;
import java.time.LocalDate;

public class Agendamento {
	private Cliente cliente;
	private Barbearia barbearia;
	private LocalDate data;
	private LocalTime horario;
	
	public Agendamento(Cliente cliente, Barbearia barbearia,
			LocalDate data, LocalTime horario) {
		if(!barbearia.dentroDoHorario(horario)) {
			throw new IllegalArgumentException(
					"Horário fora do funcionamento");
		}
		
			this.cliente = cliente;
			this.barbearia = barbearia;
			this.data = data;
			this.horario = horario;
	}
	
	public Cliente getCliente() {
		return this.cliente;
	}
	
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	
	public Barbearia getBarbearia() {
		return this.barbearia;
	}
	
	public void setBarbearia(Barbearia barbearia) {
		this.barbearia = barbearia;
	}
	
	public LocalDate getData() {
		return this.data;
	}
	
	public void setData(LocalDate data) {
		this.data = data;
	}
	
	public LocalTime getHorario() {
		return this.horario;
	}
	
	public void setHorario(LocalTime horario) {
		this.horario = horario;
	}
	
	
}
