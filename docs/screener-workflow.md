# Screener Workflow — Trading Methodology

Flujo de trabajo personal para detectar setups de momentum antes de que ocurran. Combina Finviz Elite + TradingView MCP.

---

## Tres Niveles de Screener

### 1. Expert Pre-Momentum (Swing — días a semanas)

**Objetivo:** Identificar empresas con fundamentos sólidos y catalizador próximo que aún no se movieron.

**Criterios:**
- Analyst Recommendation: Strong Buy
- Market Cap: Small Cap
- P/B < 1 (trading below book value — undervalued)
- Geografía: USA only
- Insider Ownership > 20% (management con skin in the game)
- Precio < $30
- Target Price ≥ 40% sobre precio actual
- Orden: noticia más reciente (`-newstime`)

**URL Finviz Elite:**
```
https://elite.finviz.com/export.ashx?v=151&f=an_recom_strongbuy,cap_small,fa_pb_u1,geo_usa,sh_insiderown_o20,sh_price_u30,targetprice_a40&ft=2&o=-newstime&ar=10&c=0,1,2,79,3,4,5,6,11,73,82,24,26,80,62,63,67,69,65,66,135,136&auth=YOUR_API_KEY
```

**Cuándo usar:** Swing trades, análisis pre-mercado, búsqueda de posiciones multi-día.

---

### 2. Float Bomb Activo — Screener A (Day Trade, pre-apertura 8–9am)

**Objetivo:** Detectar setups *antes* del movimiento — ideal para entrar temprano.

**Criterios:**
- Float < 10M shares
- Precio: $2–$20
- Relative Volume > 3x
- Cambio diario > 5%
- Short Float > 10% (potencial short squeeze)
- Orden: mayor relative volume primero

**URL Finviz Elite:**
```
https://elite.finviz.com/export.ashx?v=152&f=geo_usa,sh_float_u10,sh_price_o2,sh_price_u20,ta_relvol_o3,ta_change_u5,sh_short_o10&o=-relativevolume&auth=YOUR_API_KEY
```

**Cuándo usar:** Pre-apertura para armar watchlist del día.

---

### 3. Float Momentum Puro — Screener B (Day Trade, durante mercado)

**Objetivo:** Confirmar cuáles ya están en movimiento activo ese día.

**Criterios:**
- Float < 10M shares
- Precio: $2–$20
- Relative Volume > 5x
- Cambio diario > 10%
- Orden: mayor relative volume primero

**URL Finviz Elite:**
```
https://elite.finviz.com/export.ashx?v=152&f=geo_usa,sh_float_u10,sh_price_o2,sh_price_u20,ta_relvol_o5,ta_change_u10&o=-relativevolume&auth=YOUR_API_KEY
```

**Cuándo usar:** Durante mercado para confirmar momentum activo.

**Regla clave:** Float < 5M = cualquier volumen puede producir +30%+. Un ticker con 2x RVol y float de 2M puede mover igual que uno con 10x RVol y float de 50M.

---

## Flujo de Análisis por Ticker

Una vez que el screener arroja candidatos, se analiza cada uno así:

1. **Finviz** → precio actual, target price, insider%, short float, RSI, noticias recientes
2. **WebSearch** → buscar catalizador específico (earnings, FDA, contrato, dilución)
3. **TradingView** → OHLCV últimos 20 días, identificar patrón técnico
4. **Dibujar niveles** → soporte, resistencia, target analistas, ATH reciente
5. **Screenshot** → confirmar visualmente el setup

---

## Patrones Buscados

| Patrón | Ejemplo | Señal |
|--------|---------|-------|
| Consolidación + catalizador | CERS-type | Rango estrecho semanas + volumen bajo + evento en calendario |
| Post-crash recovery | CMPX/MDXG-type | Caída 30–65% + volumen de pánico declinando + soporte formándose |
| Valor + convicción | Screener experto | P/B<1 + insider >20% + target >40% upside = esperando re-rating |

---

## Rutina Diaria Pre-Mercado (Automatizada)

**Schedule:** Lunes a viernes, 8:30am Bogotá (13:30 UTC)

**Qué hace el agente:**
1. Corre los 3 screeners Finviz
2. Compara con el run anterior (requiere GitHub conectado para persistir `screener_results/last_run.json`)
3. Genera briefing en español con cambios, nuevos entrants, y tickers destacados

**Limitación importante:** El agente remoto no puede actualizar listas en TradingView (requiere MCP local). Las watchlists se actualizan manualmente al inicio de sesión usando el briefing como referencia.

---

## Timing — Cuándo Usar Cada Screener

| Momento | Screener | Acción |
|---------|----------|--------|
| Pre-apertura (8–9am) | Float Bomb (A) | Armar watchlist del día |
| Apertura–mediodía | Float Momentum (B) | Confirmar cuáles están activos |
| Cualquier momento | Expert Pre-Momentum | Buscar swing setups |
