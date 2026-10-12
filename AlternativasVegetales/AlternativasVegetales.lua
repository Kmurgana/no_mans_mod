--[[
================================================================================
  ALTERNATIVAS VEGETALES - mod para No Man's Sky (script para AMUMSS)
================================================================================
  Que hace:
    Anade recetas al Procesador de Nutrientes que fabrican los productos
    animales (leche, huevos, "miel", etc.) a partir de plantas. Asi puedes
    cocinar cualquier receta del juego sin criar ni alimentar animales.

    No borra ni cambia nada del juego: solo ANADE recetas nuevas al final de
    la tabla de recetas (METADATA/REALITY/TABLES/NMS_REALITY_GCRECIPETABLE).

  Como se usa:
    Copia esta carpeta completa (con LocTable.txt) dentro de AMUMSS\ModScript\
    y ejecuta BUILDMOD.bat. Los pasos detallados estan en el README.md.

  Para cambiar o anadir recetas edita SOLO la tabla RECETAS de abajo.
  Cada receta tiene:
    id           -> identificador unico de la receta (inventado, max. 31 letras)
    texto        -> clave del nombre que se ve en el juego. Sus traducciones
                    estan en LocTable.txt (clave "texto" y clave "texto_R")
    resultado    -> lo que sale del procesador
    ingredientes -> de 1 a 3 ingredientes (el procesador tiene 3 ranuras)

  Cada ingrediente/resultado es: { id = "ID_DEL_JUEGO", tipo = P o S, cantidad = N }
    P = "Product"   (comida y objetos fabricados: FOOD_..., etc.)
    S = "Substance" (recursos: PLANT_SNOW, WATER1, ...)
================================================================================
]]

local P = "Product"
local S = "Substance"

-- Segundos que tarda cada unidad (las recetas de cocina del juego usan 2.5)
local TIEMPO = 2.5

local RECETAS = {
  -- LECHES: base vegetal + Cristal de escarcha (hace de "agua") -------------
  {
    id = "RECIPE_ALTVEG_LECHE_AVENA",
    texto = "ALTVEG_LECHE_AVENA",
    resultado = { id = "FOOD_V_COW", tipo = P, cantidad = 1 },        -- Leche fresca
    ingredientes = {
      { id = "FOOD_P_COLDFARM", tipo = P, cantidad = 1 },             -- Granos de vidrio
      { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
    },
  },
  {
    id = "RECIPE_ALTVEG_LECHE_SOJA",
    texto = "ALTVEG_LECHE_SOJA",
    resultado = { id = "FOOD_V_MILK", tipo = P, cantidad = 1 },       -- Leche silvestre
    ingredientes = {
      { id = "FOOD_P_RADFARM", tipo = P, cantidad = 1 },              -- Judias tamizadas
      { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
    },
  },
  {
    id = "RECIPE_ALTVEG_LECHE_ARROZ",
    texto = "ALTVEG_LECHE_ARROZ",
    resultado = { id = "FOOD_V_FLYER", tipo = P, cantidad = 1 },      -- Leche de buche
    ingredientes = {
      { id = "FOOD_P_WATER", tipo = P, cantidad = 1 },                -- Arroz de alga marina
      { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
    },
  },
  {
    id = "RECIPE_ALTVEG_HORCHATA",
    texto = "ALTVEG_HORCHATA",
    resultado = { id = "FOOD_V_GEK", tipo = P, cantidad = 1 },        -- Protoleche caliente
    ingredientes = {
      { id = "PLANT_RADIO", tipo = S, cantidad = 1 },                 -- Raiz de gamma
      { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
    },
  },

  -- HUEVOS ------------------------------------------------------------------
  {
    id = "RECIPE_ALTVEG_HUEVO_LEGUMBRE",
    texto = "ALTVEG_HUEVO_LEGUMBRE",
    resultado = { id = "FOOD_V_DIPLO", tipo = P, cantidad = 1 },      -- Huevo gigante
    ingredientes = {
      { id = "FOOD_P_RADFARM", tipo = P, cantidad = 1 },              -- Judias tamizadas
      { id = "FOOD_P_COLDFARM", tipo = P, cantidad = 1 },             -- Granos de vidrio
    },
  },
  {
    id = "RECIPE_ALTVEG_HUEVO_SEMILLAS",
    texto = "ALTVEG_HUEVO_SEMILLAS",
    resultado = { id = "FOOD_V_EGG", tipo = P, cantidad = 1 },        -- Huevo de criatura
    ingredientes = {
      { id = "FOOD_P_HOTFARM", tipo = P, cantidad = 1 },              -- Solartillo
      { id = "PLANT_SNOW", tipo = S, cantidad = 1 },                  -- Cristal de escarcha
    },
  },
  {
    id = "RECIPE_ALTVEG_TOFU",
    texto = "ALTVEG_TOFU",
    resultado = { id = "FOOD_V_STRIDER", tipo = P, cantidad = 1 },    -- Huevos altos
    ingredientes = {
      { id = "FOOD_P_RADFARM", tipo = P, cantidad = 1 },              -- Judias tamizadas
      { id = "WATER1", tipo = S, cantidad = 1 },                      -- Sal
    },
  },

  -- DULCES ------------------------------------------------------------------
  {
    id = "RECIPE_ALTVEG_SIROPE_AGAVE",
    texto = "ALTVEG_SIROPE_AGAVE",
    resultado = { id = "FOOD_V_BLOB", tipo = P, cantidad = 1 },       -- "Miel" pegajosa
    ingredientes = {
      { id = "FOOD_P_DUSTFARM", tipo = P, cantidad = 1 },             -- Nectar de cactus
      { id = "PLANT_DUST", tipo = S, cantidad = 1 },                  -- Carne de cactus
    },
  },
  {
    id = "RECIPE_ALTVEG_SIROPE_BAYAS",
    texto = "ALTVEG_SIROPE_BAYAS",
    resultado = { id = "FOOD_V_PCAT", tipo = P, cantidad = 1 },       -- Nectar viscoso
    ingredientes = {
      { id = "FOOD_P_LUSHFARM", tipo = P, cantidad = 1 },             -- Baya del peregrino
      { id = "PLANT_LUSH", tipo = S, cantidad = 1 },                  -- Bulbo estelar
    },
  },

  -- GRASAS, FRUTAS Y OTROS --------------------------------------------------
  {
    id = "RECIPE_ALTVEG_MARGARINA",
    texto = "ALTVEG_MARGARINA",
    resultado = { id = "FOOD_V_REX", tipo = P, cantidad = 1 },        -- Grasa regis
    ingredientes = {
      { id = "FOOD_P_HOTFARM", tipo = P, cantidad = 1 },              -- Solartillo
      { id = "WATER1", tipo = S, cantidad = 1 },                      -- Sal
    },
  },
  {
    id = "RECIPE_ALTVEG_FRUTA_LEOPARDO",
    texto = "ALTVEG_FRUTA_LEOPARDO",
    resultado = { id = "FOOD_V_CAT", tipo = P, cantidad = 1 },        -- Fruta leopardo
    ingredientes = {
      { id = "FOOD_P_LUSHFARM", tipo = P, cantidad = 1 },             -- Baya del peregrino
      { id = "PLANT_HOT", tipo = S, cantidad = 1 },                   -- Solanio
    },
  },
  {
    id = "RECIPE_ALTVEG_MANZANA",
    texto = "ALTVEG_MANZANA",
    resultado = { id = "FOOD_V_CRAB", tipo = P, cantidad = 1 },       -- Cangrejo "manzana"
    ingredientes = {
      { id = "FOOD_P_LUSHFARM", tipo = P, cantidad = 1 },             -- Baya del peregrino
      { id = "PLANT_DUST", tipo = S, cantidad = 1 },                  -- Carne de cactus
    },
  },
  {
    id = "RECIPE_ALTVEG_PEPITAS",
    texto = "ALTVEG_PEPITAS",
    resultado = { id = "FOOD_V_BONE", tipo = P, cantidad = 1 },       -- Pepitas de hueso
    ingredientes = {
      { id = "FOOD_P_COLDFARM", tipo = P, cantidad = 1 },             -- Granos de vidrio
      { id = "WATER1", tipo = S, cantidad = 1 },                      -- Sal
    },
  },
  {
    id = "RECIPE_ALTVEG_SETAS",
    texto = "ALTVEG_SETAS",
    resultado = { id = "FOOD_V_MOLE", tipo = P, cantidad = 1 },       -- Setas recogidas
    ingredientes = {
      { id = "FOOD_P_TOXFARM", tipo = P, cantidad = 1 },              -- Seta no toxica
      { id = "PLANT_TOXIC", tipo = S, cantidad = 1 },                 -- Moho fungico
    },
  },
  {
    id = "RECIPE_ALTVEG_GELATINA_AGAR",
    texto = "ALTVEG_GELATINA_AGAR",
    resultado = { id = "FOOD_V_BUG", tipo = P, cantidad = 1 },        -- Cieno nutritivo
    ingredientes = {
      { id = "PLANT_WATER", tipo = S, cantidad = 1 },                 -- Saco de algas marinas
      { id = "FOOD_P_DUSTFARM", tipo = P, cantidad = 1 },             -- Nectar de cactus
    },
  },
  {
    id = "RECIPE_ALTVEG_REGALIZ",
    texto = "ALTVEG_REGALIZ",
    resultado = { id = "FOOD_V_ROBOT", tipo = P, cantidad = 1 },      -- Cables gomosos
    ingredientes = {
      { id = "PLANT_RADIO", tipo = S, cantidad = 1 },                 -- Raiz de gamma
      { id = "FOOD_P_DUSTFARM", tipo = P, cantidad = 1 },             -- Nectar de cactus
    },
  },
}

--==============================================================================
-- A partir de aqui no hace falta tocar nada.
--==============================================================================

-- Comprobaciones para detectar errores al editar la tabla RECETAS.
-- Si algo esta mal, AMUMSS mostrara el mensaje y no creara el mod.
local function ComprobarElemento(e, donde)
  if type(e.id) ~= "string" or e.id == "" or #e.id > 15 then
    error(donde .. ": 'id' debe ser un texto de 1 a 15 caracteres")
  end
  if e.tipo ~= P and e.tipo ~= S then
    error(donde .. " (" .. e.id .. "): 'tipo' debe ser P o S")
  end
  if type(e.cantidad) ~= "number" or e.cantidad < 1 or math.floor(e.cantidad) ~= e.cantidad then
    error(donde .. " (" .. e.id .. "): 'cantidad' debe ser un numero entero >= 1")
  end
end

local function ComprobarRecetas()
  local ids = {}
  local combinaciones = {}
  for i, r in ipairs(RECETAS) do
    local donde = "Receta " .. i
    if type(r.id) ~= "string" or r.id == "" or #r.id > 31 then
      error(donde .. ": 'id' debe ser un texto de 1 a 31 caracteres")
    end
    if ids[r.id] then
      error(donde .. ": el id '" .. r.id .. "' esta repetido")
    end
    ids[r.id] = true
    if type(r.texto) ~= "string" or r.texto == "" or #r.texto > 29 then
      error(r.id .. ": 'texto' debe ser un texto de 1 a 29 caracteres")
    end
    ComprobarElemento(r.resultado, r.id .. " resultado")
    if #r.ingredientes < 1 or #r.ingredientes > 3 then
      error(r.id .. ": debe tener de 1 a 3 ingredientes")
    end
    local lista = {}
    for j, ing in ipairs(r.ingredientes) do
      ComprobarElemento(ing, r.id .. " ingrediente " .. j)
      lista[j] = ing.id
    end
    -- Dos recetas con los mismos ingredientes no pueden funcionar a la vez
    table.sort(lista)
    local clave = table.concat(lista, "+")
    if combinaciones[clave] then
      error(r.id .. ": usa los mismos ingredientes que " .. combinaciones[clave])
    end
    combinaciones[clave] = r.id
  end
end

-- Convierte un ingrediente o el resultado al formato MXML del juego.
-- 'nombre' es "Result" para el resultado e "Ingredients" para cada ingrediente.
local function ElementoMXML(nombre, e, sangria)
  local atributo_id = ""
  if nombre == "Ingredients" then
    atributo_id = ' _id="' .. e.id .. '"'
  end
  return table.concat({
    sangria .. '<Property name="' .. nombre .. '" value="GcRefinerRecipeElement"' .. atributo_id .. '>',
    sangria .. '  <Property name="Id" value="' .. e.id .. '" />',
    sangria .. '  <Property name="Type" value="GcInventoryType">',
    sangria .. '    <Property name="InventoryType" value="' .. e.tipo .. '" />',
    sangria .. '  </Property>',
    sangria .. '  <Property name="Amount" value="' .. string.format("%d", e.cantidad) .. '" />',
    sangria .. '</Property>',
  }, "\n")
end

-- Convierte una receta al formato MXML (una entrada de la lista "Table").
-- Cooking = true hace que sea una receta del Procesador de Nutrientes.
local function RecetaMXML(r)
  local lineas = {
    '    <Property name="Table" value="GcRefinerRecipe" _id="' .. r.id .. '">',
    '      <Property name="Id" value="' .. r.id .. '" />',
    '      <Property name="RecipeType" value="' .. r.texto .. '" />',
    '      <Property name="RecipeName" value="' .. r.texto .. '_R" />',
    '      <Property name="TimeToMake" value="' .. TIEMPO .. '" />',
    '      <Property name="Cooking" value="true" />',
    ElementoMXML("Result", r.resultado, "      "),
    '      <Property name="Ingredients">',
  }
  for _, ing in ipairs(r.ingredientes) do
    lineas[#lineas + 1] = ElementoMXML("Ingredients", ing, "        ")
  end
  lineas[#lineas + 1] = '      </Property>'
  lineas[#lineas + 1] = '    </Property>'
  return table.concat(lineas, "\n")
end

ComprobarRecetas()

local recetas_mxml = {}
for i, r in ipairs(RECETAS) do
  recetas_mxml[i] = RecetaMXML(r)
end
local TEXTO_RECETAS = table.concat(recetas_mxml, "\n") .. "\n"

NMS_MOD_DEFINITION_CONTAINER = {
  ["MOD_FILENAME"]    = "AlternativasVegetales",
  ["MOD_AUTHOR"]      = "kmurgana",
  ["NMS_VERSION"]     = "7.x",
  ["MOD_DESCRIPTION"] = "Recetas del Procesador de Nutrientes que crean leche, huevos, miel y demas productos animales a partir de plantas",
  ["MODIFICATIONS"]   = {
    {
      ["MBIN_CHANGE_TABLE"] = {
        {
          ["MBIN_FILE_SOURCE"] = "METADATA/REALITY/TABLES/NMS_REALITY_GCRECIPETABLE.MBIN",
          ["MXML_CHANGE_TABLE"] = {
            {
              -- Busca la lista "Table" (todas las recetas del juego) y anade
              -- las nuestras al final, dentro de la lista.
              ["PRECEDING_KEY_WORDS"] = { "Table" },
              ["ADD_OPTION"]          = "ADDendSECTION",
              ["ADD"]                 = TEXTO_RECETAS,
            },
          },
        },
      },
    },
  },
}
