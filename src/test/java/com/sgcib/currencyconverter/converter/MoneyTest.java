package com.sgcib.currencyconverter.converter;

import static org.junit.Assert.*;

import org.junit.Test;

public class MoneyTest {

	@Test
	public void shouldConvertItselfToAString() {
		Money money = new Money(48.07, "EUR");
		assertEquals("Money{quantity=48.07, currency='EUR'}", money.toString());
	}
	@Test
	public void shouldCompareToAnotherMoney() {
		Money eur48 = new Money(48, "EUR");
		assertEquals(eur48, new Money(48, "EUR"));
	}
	@Test
	public void shouldCompareToAnotherMoneyWithAMargin() {
		Money eur48 = new Money(48, "EUR");
		assertEquals(eur48, new Money(48.0000001, "EUR"));
		assertNotEquals(eur48, new Money(48.000002, "EUR"));
		
	}

}
