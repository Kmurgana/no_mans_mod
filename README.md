# Alternativas Vegetales: mod para No Man's Sky

Este mod añade **16 recetas al Procesador de Nutrientes** que producen todos los productos animales del juego (leches, huevos, «miel», grasa, etc.) **a partir de plantas**. Así puedes cocinar cualquier receta sin criar ni alimentar animales.

No quita ni cambia nada del juego: solo **añade** recetas nuevas. Los productos que salen son los de siempre (Leche fresca, Huevo gigante…), así que todas las recetas de cocina del juego los aceptan.

---

## Recetas que añade

Cada receta usa **1 + 1 ingredientes → 1 producto**. Puedes meter pilas enteras: 10 + 10 → 10.

| Producto animal que obtienes | Ingredientes (Procesador de Nutrientes) | Nombre de la receta |
|---|---|---|
| **Leche fresca** (Fresh Milk) | Granos de vidrio + Cristal de escarcha | Leche de avena |
| **Leche silvestre** (Wild Milk) | Judías tamizadas + Cristal de escarcha | Leche de soja |
| **Leche de buche** (Craw Milk) | Arroz de alga marina + Cristal de escarcha | Leche de arroz |
| **Protoleche caliente** (Warm Proto-Milk) | Raíz de gamma + Cristal de escarcha | Horchata de chufa |
| **Huevo gigante** (Giant Egg) | Judías tamizadas + Granos de vidrio | Huevo de harina de legumbres |
| **Huevo de criatura** (Creature Egg) | Solartillo + Cristal de escarcha | Huevo de semillas |
| **Huevos altos** (Tall Eggs) | Judías tamizadas + Sal | Tofu revuelto |
| **«Miel» pegajosa** (Sticky 'Honey') | Néctar de cactus + Carne de cactus | Sirope de agave |
| **Néctar viscoso** (Syrupy Nectar) | Baya del peregrino + Bulbo estelar | Sirope de bayas |
| **Grasa regis** (Regis Grease) | Solartillo + Sal | Margarina vegetal |
| **Fruta leopardo** (Leopard-Fruit) | Baya del peregrino + Solanio | Fruta leopardo de huerto |
| **Cangrejo «manzana»** (Crab 'Apple') | Baya del peregrino + Carne de cactus | «Manzana» de huerto |
| **Pepitas de hueso** (Bone Nuggets) | Granos de vidrio + Sal | Pepitas de cereal tostado |
| **Setas recogidas** (Foraged Mushrooms) | Seta no tóxica + Moho fúngico | Setas de cultivo |
| **Cieno nutritivo** (Nourishing Slime) | Saco de algas marinas + Néctar de cactus | Gelatina de agar |
| **Cables gomosos** (Chewy Wires) | Raíz de gamma + Néctar de cactus | Regaliz |

### De dónde salen los ingredientes

Casi todo sale de **6 plantas que puedes cultivar en tu base**: Cristal de escarcha, Raíz de gamma, Solanio, Bulbo estelar, Carne de cactus y Moho fúngico. Los demás ingredientes se fabrican con esas plantas usando recetas que **ya trae el juego** en el Procesador de Nutrientes:

| Ingrediente | Cómo conseguirlo (receta original del juego) |
|---|---|
| Granos de vidrio | Procesador: Cristal de escarcha |
| Judías tamizadas | Procesador: Raíz de gamma |
| Solartillo | Procesador: Solanio |
| Baya del peregrino | Procesador: Bulbo estelar |
| Néctar de cactus | Procesador: Carne de cactus |
| Seta no tóxica | Procesador: Moho fúngico |
| Arroz de alga marina | Procesador: Saco de algas marinas (de las algas submarinas) |
| Sal | Minerales submarinos |

Solo dos recetas (Leche de buche y Cieno nutritivo) necesitan algas submarinas. Las tres que llevan Sal necesitan minerales submarinos.

---

## ¿Cómo funciona un mod de No Man's Sky? (explicación rápida)

1. Los datos del juego (objetos, recetas, textos…) están dentro de archivos comprimidos en `No Man's Sky\GAMEDATA\PCBANKS`. Dentro hay archivos **.MBIN**, que son tablas binarias. Por ejemplo, todas las recetas están en `METADATA\REALITY\TABLES\NMS_REALITY_GCRECIPETABLE.MBIN`.
2. Un mod es una **carpeta dentro de `No Man's Sky\GAMEDATA\MODS`** con versiones modificadas de esos archivos. El juego las carga al arrancar.
3. Para no editar binarios a mano se usa **AMUMSS**, una herramienta de la comunidad. Tú le das un **script Lua** que describe los cambios, y AMUMSS se encarga del resto:
   - saca el archivo original de **tu** copia del juego,
   - lo convierte a texto (formato MXML) con **MBINCompiler**,
   - aplica los cambios del script,
   - lo vuelve a compilar y deja el mod listo en `GAMEDATA\MODS`.
4. Como el script describe *cambios* y no contiene los archivos del juego, cuando el juego se actualiza basta con volver a ejecutar AMUMSS.

Este mod tiene solo dos archivos:

```
AlternativasVegetales\
├── AlternativasVegetales.lua   ← el script: la lista de recetas y cómo añadirlas
└── LocTable.txt                ← los nombres de las recetas en cada idioma
```

---

## Requisitos

- **PC con Windows** y el juego en Steam, GOG o Xbox/Microsoft Store. En consolas no hay mods. En Mac la carpeta `GAMEDATA\MODS` no funciona.
- **.NET 8 Desktop Runtime (x64)**, que MBINCompiler necesita: <https://dotnet.microsoft.com/download/dotnet/8.0>. Tiene que ser la versión 8: otras versiones (6, 9, 10…) no sirven.
- **7-Zip**, para descomprimir AMUMSS: <https://www.7-zip.org/download.html>
- **AMUMSS**: <https://github.com/HolterPhylo/AMUMSS/releases> (descarga `AMUMSS.7z` de la versión *Latest*). También está en Nexus Mods (mod 2626 de No Man's Sky).

---

## Instalación paso a paso

### 1. Prepara AMUMSS (solo la primera vez)

1. Instala el **.NET 8 Desktop Runtime x64**.
2. Descarga `AMUMSS.7z`. Haz clic derecho → **Propiedades** → marca **Desbloquear** → Aceptar.
3. Descomprímelo con 7-Zip en una carpeta nueva, por ejemplo `C:\AMUMSS`.
   - **No** lo pongas en el Escritorio, Descargas ni Documentos.
   - La ruta **no** debe tener acentos ni ñ.
   - Algunos antivirus bloquean AMUMSS por error. Si pasa, añade `C:\AMUMSS` como excepción del antivirus.
4. Haz doble clic en **`BUILDMOD.bat`**. La primera vez se actualiza y descarga MBINCompiler. Repite hasta que no ofrezca más actualizaciones y exista la carpeta `C:\AMUMSS\ModScript`.

### 2. Añade este mod

1. Descarga este repositorio (botón verde **Code → Download ZIP** en GitHub) y descomprímelo.
2. Copia la carpeta **`AlternativasVegetales`** entera dentro de `C:\AMUMSS\ModScript\`. Debe quedar así:

   ```
   C:\AMUMSS\ModScript\AlternativasVegetales\AlternativasVegetales.lua
   C:\AMUMSS\ModScript\AlternativasVegetales\LocTable.txt
   ```

### 3. Crea el mod

1. Ejecuta **`BUILDMOD.bat`** otra vez.
2. AMUMSS te hará algunas preguntas (pueden cambiar según la versión). Respuestas recomendadas:
   - **Versión del juego**: `P` (pública). Usa `E` solo si juegas en la rama *experimental* de Steam o GOG.
   - **Modo** (FULL/DEV/LEAN): `L` (LEAN) va bien.
   - **¿Combinar mods?**: `N` (mods individuales).
   - **¿Copiar los mods a la carpeta del juego?**: `ALL` o `Y`.
3. Cuando termine, comprueba que existe la carpeta del mod:

   ```
   ...\No Man's Sky\GAMEDATA\MODS\AlternativasVegetales\
   ```

   Dentro debe haber una carpeta `METADATA` y el archivo `LocTable.MXML`, que AMUMSS genera a partir de `LocTable.txt`.

### 4. Juega

Arranca el juego. Al detectar mods, el juego muestra un aviso al inicio: acéptalo.

---

## Cómo probar que funciona

1. Ve a un **Procesador de Nutrientes**.
2. Pon **1 Granos de vidrio** y **1 Cristal de escarcha**.
3. Debe salir **Leche fresca**, y el procesador debe mostrar *«Configuración de procesador: leche de avena»*.

Si sale la Leche fresca pero ves un código como `ALTVEG_LECHE_AVENA_R` en vez del nombre, el mod funciona pero los textos no se han cargado. Revisa que en la carpeta del script esté `LocTable.txt` (y **no** un `LocTable.MXML`: ver [Si algo falla](#si-algo-falla)) y vuelve a ejecutar `BUILDMOD.bat`.

---

## Cambiar o añadir recetas

Todo se hace en `AlternativasVegetales.lua`, en la tabla **`RECETAS`** del principio del archivo. Ábrelo con el Bloc de notas (o mejor, con [Notepad++](https://notepad-plus-plus.org/) o VS Code). Cada receta tiene este aspecto:

```lua
{
  id = "RECIPE_ALTVEG_LECHE_AVENA",          -- nombre interno único (máx. 31 letras)
  texto = "ALTVEG_LECHE_AVENA",              -- clave del nombre (ver LocTable.txt)
  resultado = { id = "FOOD_V_COW", tipo = P, cantidad = 1 },        -- Leche fresca
  ingredientes = {
    { id = "FOOD_P_COLDFARM", tipo = P, cantidad = 1 },             -- Granos de vidrio
    { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
  },
},
```

- `tipo` es **`P`** para productos (comida: `FOOD_...`) y **`S`** para sustancias (recursos: `PLANT_...`, `WATER1`…).
- Puedes poner de **1 a 3 ingredientes**, porque el procesador tiene 3 ranuras.
- Puedes subir las `cantidad` si quieres que las recetas sean más caras (por ejemplo, 2 + 1 → 1).
- **Cada receta necesita una combinación de ingredientes única.** Si coincide con otra del mod, el script te avisa. Si coincide con una receta del juego, una de las dos no funcionará: pruébala en el juego.
- Si añades una receta nueva, añade también sus dos textos en `LocTable.txt`: una línea `=TU_CLAVE` seguida de una línea por idioma (`EN=texto`, `ES=texto`…), y lo mismo para `=TU_CLAVE_R`. Copia un bloque existente y cambia la clave y los textos. `ES` es el español de España, `LA` el de Latinoamérica, `EN`/`US` el inglés, y el resto de códigos (`FR`, `DE`, `IT`, `PT`, `BR`, `RU`, `PL`, `NL`, `Z1`, `ZH`, `Z2`, `KO`, `JA`) los demás idiomas del juego.

Después vuelve a ejecutar `BUILDMOD.bat`. Si te equivocas al editar (un tipo que no es `P`/`S`, una cantidad con decimales, un `id` repetido…), el script se detiene y explica el error en español.

### IDs útiles

**Productos animales** (tipo `P`):

| ID | Nombre | ID | Nombre |
|---|---|---|---|
| `FOOD_V_COW` | Leche fresca | `FOOD_V_BLOB` | «Miel» pegajosa |
| `FOOD_V_MILK` | Leche silvestre | `FOOD_V_PCAT` | Néctar viscoso |
| `FOOD_V_FLYER` | Leche de buche | `FOOD_V_REX` | Grasa regis |
| `FOOD_V_GEK` | Protoleche caliente | `FOOD_V_CAT` | Fruta leopardo |
| `FOOD_V_DIPLO` | Huevo gigante | `FOOD_V_CRAB` | Cangrejo «manzana» |
| `FOOD_V_EGG` | Huevo de criatura | `FOOD_V_BONE` | Pepitas de hueso |
| `FOOD_V_STRIDER` | Huevos altos | `FOOD_V_MOLE` | Setas recogidas |
| `FOOD_V_BUG` | Cieno nutritivo | `FOOD_V_ROBOT` | Cables gomosos |

**Comida vegetal** (tipo `P`):

| ID | Nombre | ID | Nombre |
|---|---|---|---|
| `FOOD_P_COLDFARM` | Granos de vidrio | `FOOD_P_ALL1` | Trigo heptaploide |
| `FOOD_P_RADFARM` | Judías tamizadas | `FOOD_P_ALL2` | Raíz dulce |
| `FOOD_P_HOTFARM` | Solartillo | `FOOD_P_ALL3` | Raíces pulposas |
| `FOOD_P_LUSHFARM` | Baya del peregrino | `FOOD_P_TOXWILD` | Guisantes de jade |
| `FOOD_P_DUSTFARM` | Néctar de cactus | `FOOD_P_LUSHWILD` | Judiones de impulso |
| `FOOD_P_TOXFARM` | Seta no tóxica | `FOOD_P_HOTWILD` | Baya de fuego |
| `FOOD_P_WATER` | Arroz de alga marina | `FOOD_P_RADWILD` | Baya grah |
| `FOOD_P_CAVE` | Pulpa de calabaza | `FOOD_P_COLDWILD` | Tubérculos congelados |

**Sustancias** (tipo `S`):

| ID | Nombre | ID | Nombre |
|---|---|---|---|
| `PLANT_SNOW` | Cristal de escarcha | `PLANT_LUSH` | Bulbo estelar |
| `PLANT_RADIO` | Raíz de gamma | `PLANT_DUST` | Carne de cactus |
| `PLANT_HOT` | Solanio | `PLANT_TOXIC` | Moho fúngico |
| `PLANT_WATER` | Saco de algas marinas | `PLANT_CAVE` | Bulbo de médula |
| `WATER1` | Sal | `FUEL1` | Carbono |

Para ver *todos* los archivos del juego en formato texto, AMUMSS puede descomprimirlos (consulta su documentación en `C:\AMUMSS\README`).

---

## Cuando el juego se actualice

Vuelve a ejecutar `BUILDMOD.bat`. AMUMSS descarga solo el MBINCompiler nuevo y reconstruye el mod con los archivos actualizados del juego. Si da error justo después de una actualización grande, puede que MBINCompiler aún no esté adaptado: espera unos días y vuelve a probar.

## Desinstalar

Borra la carpeta `No Man's Sky\GAMEDATA\MODS\AlternativasVegetales`. La comida que ya hayas cocinado son objetos normales del juego, así que se queda en tu inventario.

## Si algo falla

- **AMUMSS muestra errores**: revisa el archivo `REPORT.lua` que deja en su carpeta principal. Ahí explica qué falló.
- **El mod no se carga**: comprueba que está en `GAMEDATA\MODS` (no en `PCBANKS\MODS`, que era el sistema antiguo). Si sigue sin cargar, cierra el juego y borra `No Man's Sky\Binaries\SETTINGS\GCMODSETTINGS.MXML`: el juego lo vuelve a crear al arrancar. En ese archivo también puedes desactivar un mod poniendo `Enabled` en `false`.
- **Una receta concreta no funciona**: puede que una actualización del juego haya añadido una receta con los mismos ingredientes. Cámbiale un ingrediente en la tabla `RECETAS` y reconstruye.
- **Las recetas funcionan pero se ven códigos como `ALTVEG_..._R`**: en la carpeta del script tiene que estar `LocTable.txt`. No pongas ahí un `LocTable.MXML`: AMUMSS 5.6.2.0w busca ese archivo en otra carpeta y acaba generando un archivo de textos vacío. Borra la carpeta `ModScript\AlternativasVegetales`, vuelve a copiar la del mod y ejecuta `BUILDMOD.bat`.
- **Ayuda de la comunidad**: el Discord *No Man's Sky Modding* tiene un canal `#amumss-lua` dedicado a AMUMSS.

---

## Cómo se ha comprobado

No pude ejecutar el juego ni AMUMSS al preparar el mod, porque ambos son programas de Windows. Esto es lo que sí se comprobó:

- El script se ejecuta sin errores en Lua 5.4, y su estructura pasa la validación de claves y tipos del propio AMUMSS (`CheckContainer.lua`).
- El MXML que genera es XML válido, y sus campos y su orden coinciden con las definiciones de MBINCompiler (`GcRefinerRecipe`, `GcRefinerRecipeElement`, `GcInventoryType`, `TkLocalisationEntry`). El formato es el mismo que usan scripts publicados para la versión 7.00 del juego en la colección oficial de scripts de AMUMSS.
- Los IDs de los objetos existen en el juego y tienen el tipo correcto (producto o sustancia).
- Ninguna de las 16 combinaciones de ingredientes coincide con las 1.323 recetas originales del Procesador de Nutrientes (datos de 2025). Si una actualización posterior añadió una receta igual, cambia esa combinación.
- Los controles de errores del script detectan ids repetidos, combinaciones repetidas, tipos incorrectos y cantidades no enteras.
- `LocTable.txt` se convirtió con el código de AMUMSS (las funciones de `LoadHelpers.lua`) y da un `LocTable.MXML` con las 32 claves en los 17 idiomas. El script pasa el analizador selene con la configuración de AMUMSS sin errores ni avisos.

La prueba definitiva es la del apartado [Cómo probar que funciona](#cómo-probar-que-funciona).
