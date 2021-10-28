
Better unit display (translation?)
x Persistent database
- Export/import data
- clear db
x Data schema upgrades
- check/fix aggregation totals
x delete items
x edit items
x amend up and down contents
- prettier UI
- detect cycles in db on start
- 
- add meals
- name
- datetime
- edible contents
- comments
- edit/delete
- display meals by date
- calendar showing stats

- add measurements
- blood pressure dia/sys/rate
- blood sugar

Bug:
- can't add energy > 100g
- energy units not shown and/or is wrong?

Performing hot reload...
Syncing files to device XT1032...
I/flutter (13785): future aggregation...
I/flutter (13785): aggregate called
I/flutter (13785): entities (MapEntry(Symbol("Tahini"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))), MapEntry(Symbol("Salad"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))))
I/flutter (13785): null snapshot.data Bad state: Cannot aggregate this ingredient list as it contains a cyclic reference to the edible ID #Cabbage
I/flutter (13785): entities ()
Reloaded 1 of 835 libraries in 3,207ms.
I/flutter (13785): _aggregate {Symbol("Tahini"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0)), Symbol("Salad"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))}
I/flutter (13785): _aggregate {Symbol("Carbs"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0)), Symbol("Fat"): Quantity(amount: 2.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))}
I/flutter (13785): result {Symbol("Carbs"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0)), Symbol("Fat"): Quantity(amount: 2.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))}
I/flutter (13785): multiplier = 1.0 * 100.0 = 100.0
I/flutter (13785): Quantity = 1.0 * 100.0 = 100.0
I/flutter (13785): Quantity = 2.0 * 100.0 = 200.0
I/flutter (13785): _aggregate {Symbol("Cabbage"): Quantity(amount: 2.0, units: Units(id: g, dims: Mass, multiplier: 1.0)), Symbol("Tahini"): Quantity(amount: 1.0, units: Units(id: g, dims: Mass, multiplier: 1.0))}
I/flutter (13785): _aggregate {Symbol("Cabbage"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0)), Symbol("Carbs"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0)), Symbol("Fibre"): Quantity(amount: 1.0, units: Units(id: g_per_hg, dims: FractionByMass, multiplier: 100.0))}
I/flutter (13785): Edible(id: Tahini, isDish: false, contents: {#Carbs: 1.0 g_per_hg,#Fat: 2.0 g_per_hg})
I/flutter (13785): Edible(id: Salad, isDish: false, contents: {#Tahini: 1.0 g,#Cabbage: 2.0 g})
I/flutter (13785): Edible(id: ghffc, isDish: false, contents: {#Cabbage: 1.0 g_per_hg,#Tahini: 1.0 g_per_hg})
I/flutter (13785): Edible(id: bggnc, isDish: true, contents: {#Tahini: 1.0 g_per_hg})
I/flutter (13785): Edible(id: , isDish: false, contents: {#Tahini: 1.0 g_per_hg,#Cabbage: 1.0 g_per_hg,#gghh: 2.0 g_per_hg,#ghffc: 10 g_per_hg})
I/flutter (13785): Edible(id: ghyf, isDish: true, contents: {#Tahini: 5.0 g_per_hg,#Cabbage: 2.0 g_per_hg})
I/flutter (13785): Edible(id: hij, isDish: true, contents: {#Tahini: 2.0 g_per_hg,#Cabbage: 2.0 g_per_hg})
I/flutter (13785): Edible(id: ghhh, isDish: false, contents: {#Tahini: 1.0 g_per_hg,#Salad: 1.0 g_per_hg})
I/flutter (13785): Edible(id: cx, isDish: false, contents: {#Tahini: 3.0 g_per_hg,#Salad: 2.0 g_per_hg})
I/flutter (13785): Edible(id: Cabbage, isDish: false, contents: {#Carbs: 1.0 g_per_hg,#Fibre: 1.0 g_per_hg,#Cabbage: 1.0 g_per_hg})
I/flutter (13785): Edible(id: gghh, isDish: false, contents: {#Tahini: 6.0 g_per_hg,#Cabbage: 2.0 g_per_hg})
I/flutter (13785): Edible(id: gjjyff, isDish: false, contents: {#Tahini: 4.0 g_per_hg,#Salad: 1.0 g_per_hg,#Cabbage: 3.0 g_per_hg})
I/flutter (13785): null snapshot.data Bad state: Cannot aggregate this ingredient list as it contains a cyclic reference to the edible ID #Cabbage
I/flutter (13785): entities ()
