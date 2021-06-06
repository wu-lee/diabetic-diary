# MODEL

Records have a timestamp, 
possibly with a precision, 
possibly with a note, tags

Blood glucose measurements are kinds of record
they have a timestamp and a concentration

A concentration is a dimensioned quantity

Body mass measurements are kinds of record
they have a timestamp and a mass

Mass is a dimensioned quantity

blood pressure measurements are kinds of record
they have a timestamp and a systolic, diastolic, and heart rate
these are dimensioned quantities

logged meals have a timestamp, an optional description, tags, and a list of ingredients,
and an aggregate list of composition statistics
logged meals are kinds of record

ingredients have names, and a list of composition statistics

dishes are kinds of ingredient
dishes have names, a list of ingredients, and an aggregate list of measurement types

a composition statistic has a name, a measurement type, and a quantity

a dimension has a name and a list of allowed units with their relative sizes
one of these units is the base unit

a quantity has a dimension, units and an amount

dimensions are one of
- mass
- fraction by mass
- volume
- fraction by volume
- energy
- energy by mass
- mMol/dL
- pressure
- frequency AKA rate

measurement types are one of
- fat
- saturated fat
- energy
- carbohydrates
- fibre
- protein
- salt

## Classes

### MeasurementType

- name: String
- units: Dimensions

e.g.
- Blood Pressure (pressure)
- Body weight (mass)
- Calories (energy)
- Blood sugar (concentration)

### Dimensions

- name: String
- elements: DimensionElement set
- units: DimensionUnit set

e.g. 
- Area (metre^2)
- Velocity (metre, second^-1)
- Energy (Joule => gram meter^2 second-1)

### Dimension

- name: String
- units: DimensionUnit

e.g.
- Mass (gram)
- Distance (metre)
- Time (second)

### DimensionElement

- dimension: Dimension
- exponent: int

e.g.
- metre
- metre^2
- gram meter^2 second-1

### DimensionUnit

- name: String
- dimension: Dimension
- multiplier: float

e.g
- Mass
    - Metre (1)
    - Kilometre (10^3)
    - Centimeter (10^-2)
