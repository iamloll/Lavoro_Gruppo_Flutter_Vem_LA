import 'dart:convert';
import 'package:zdor_app/models/recipe.dart';

//Servizio per le ricette
class RecipesService {

  //Ottenere una lista di ricette dal Json
  Iterable<Recipe> getRecipes({int results = 10}) {
    //Leggo il json e lo trasformo in una mappa di stringhe e dynamic
    final Map<String, dynamic> data = jsonDecode(recipesJson);

    //Creo un Iterable di ricette dalla mappa 
    final toReturn = List<Recipe>.from(
      data['recipes']!.map((x) => Recipe.fromJson(x)).take(results),
    );

    return toReturn;
  }  
}

//Json iniziale di ricette
const recipesJson = '''
{
  "recipes": 
  [
    {
      "id": "1",
      "isFavourite" : "false",
      "title": "Spaghetti alla carbonara",
      "category": "Primi",
      "image": "assets/image_recipes/carbonara.jpg",
      "ingredients_list": [
        "Spaghetti",
        "Uova",
        "Guanciale",
        "Pecorino",
        "Pepe nero"
      ],
      "procedure": "Cuocere gli spaghetti al dente. Nel frattempo, in una padella, far rosolare il guanciale. In una ciotola, sbattere le uova con il pecorino e il pepe. Scolare gli spaghetti e saltarli nella padella con il guanciale. Aggiungere la miscela di uova e pecorino e mescolare rapidamente fino a ottenere una crema omogenea. Servire caldo.",
      "prep_time": "20 minuti"
    },
    {
      "id": "2",
      "isFavourite" : "false",
      "title": "Risotto ai funghi",
      "category": "Primi",
      "image": "assets/image_recipes/risotto_funghi.jpg",
      "ingredients_list": [
        "Riso",
        "Funghi porcini",
        "Brodo di carne",
        "Burro",
        "Cipolla",
        "Vino bianco",
        "Parmigiano",
        "Prezzemolo"
      ],
      "procedure": "Far rosolare la cipolla con il burro in una pentola. Aggiungere il riso e tostarlo leggermente. Sfumare con il vino bianco e aggiungere i funghi tagliati a pezzetti. Aggiungere gradualmente il brodo di carne caldo e cuocere mescolando fino a quando il riso è cotto. Mantecare con il parmigiano e il prezzemolo tritato.",
      "prep_time": "40 minuti"
    },
    {
      "id": "3",
      "isFavourite" : "false",
      "title": "Spaghetti alle vongole",
      "category": "Primi",
      "image": "assets/image_recipes/spaghetti_vongole.jpg",
      "ingredients_list": [
        "Spaghetti",
        "Vongole",
        "Aglio",
        "Prezzemolo",
        "Peperoncino",
        "Vino bianco",
        "Olio extravergine d'oliva"
      ],
      "procedure": "Far aprire le vongole in una padella con aglio, prezzemolo e peperoncino. Cuocere gli spaghetti in acqua salata. Scolare gli spaghetti e saltarli nella padella con le vongole. Aggiungere un po' di vino bianco e cuocere finché il liquido si sarà ridotto. Servire caldi.",
      "prep_time": "30 minuti"
    },
    {
      "id": "4",
      "isFavourite" : "true",
      "title": "Lasagne al forno",
      "category": "Primi",
      "image": "assets/image_recipes/lasagne.jpg",
      "ingredients_list": [
        "Lasagne",
        "Carne macinata",
        "Passata di pomodoro",
        "Besciamella",
        "Parmigiano",
        "Mozzarella",
        "Olio extravergine d'oliva"
      ],
      "procedure": "Preparare la salsa di carne rosolando la carne macinata con la passata di pomodoro. Preparare la besciamella. In una teglia da forno, alternare strati di pasta, salsa di carne, besciamella e formaggio. Cuocere in forno preriscaldato a 180°C per circa 30 minuti.",
      "prep_time": "90 minuti"
    },
    {
      "id": "5",
      "isFavourite" : "false",
      "title": "Minestrone",
      "category": "Primi",
      "image": "assets/image_recipes/minestrone.jpg",
      "ingredients_list": [
        "Zucchine",
        "Patate",
        "Carote",
        "Cipolla",
        "Sedano",
        "Fagiolini",
        "Pomodori",
        "Fagioli cannellini",
        "Verdure miste a piacere (quali cavolo, spinaci, porri)",
        "Brodo vegetale o acqua",
        "Olio extravergine d'oliva",
        "Sale",
        "Pepe"
      ],
      "procedure": "Tagliare tutte le verdure a pezzetti. In una pentola capiente, far soffriggere la cipolla con un po' di olio d'oliva. Aggiungere le altre verdure e farle rosolare per alcuni minuti. Aggiungere il brodo vegetale o l'acqua sufficiente a coprire le verdure e cuocere a fuoco medio-basso per circa 30-40 minuti, fino a quando le verdure saranno tenere. Aggiustare di sale e pepe secondo il proprio gusto. Servire caldo.",
      "prep_time": "45 minuti"
    },    
    {
      "id": "6",
      "isFavourite" : "false",
      "title": "Muffin al cioccolato",
      "category": "Colazione",
      "image": "assets/image_recipes/muffin_cioccolato.jpg",
      "ingredients_list": [
        "Farina",
        "Zucchero",
        "Cacao in polvere",
        "Baking powder",
        "Sale",
        "Uova",
        "Latte",
        "Olio vegetale",
        "Gocce di cioccolato"
      ],
      "procedure": "Preriscaldare il forno a 180°C e preparare una teglia per muffin con pirottini di carta. In una ciotola grande, mescolare insieme la farina, lo zucchero, il cacao in polvere, il baking powder e il sale. In un'altra ciotola, sbattere leggermente le uova, quindi aggiungere il latte e l'olio vegetale. Versare gli ingredienti liquidi nella ciotola degli ingredienti secchi e mescolare fino a che gli ingredienti siano appena combinati. Aggiungere le gocce di cioccolato e mescolare delicatamente. Distribuire l'impasto nei pirottini per muffin riempiendoli fino a 3/4. Infornare e cuocere per circa 20-25 minuti, o fino a quando uno stecchino inserito nel centro esca pulito. Lasciare raffreddare i muffin sulla teglia per qualche minuto prima di trasferirli su una griglia per raffreddare completamente.",
      "prep_time": "30 minuti"
    },
    {
      "id": "7",
      "isFavourite" : "false",
      "title": "Pancake",
      "category": "Colazione",
      "image": "assets/image_recipes/pancake.jpg",
      "ingredients_list": [
        "Farina",
        "Zucchero",
        "Lievo in polvere",
        "Sale",
        "Latte",
        "Uovo",
        "Burro fuso"
      ],
      "procedure": "In una ciotola, mescolare la farina, lo zucchero, il lievito in polvere e il sale. In un'altra ciotola, sbattere leggermente l'uovo, quindi aggiungere il latte e il burro fuso. Versare gli ingredienti liquidi nella ciotola degli ingredienti secchi e mescolare fino a ottenere un composto omogeneo, ma non troppo liscio. Scaldare leggermente una padella antiaderente a fuoco medio e ungere con un po' di burro. Versare un mestolo di impasto nella padella e cuocere fino a quando compaiono delle bolle sulla superficie, quindi girare e cuocere dall'altro lato finché dorato. Continuare con il resto dell'impasto. Servire i pancake caldi con sciroppo d'acero, frutta fresca o altri condimenti a piacere.",
      "prep_time": "20 minuti"
    },
    {
      "id": "8",
      "isFavourite" : "false",
      "title": "Croissant alla crema",
      "category": "Colazione",
      "image": "assets/image_recipes/croissant_crema.jpg",
      "ingredients_list": [
        "Pasta sfoglia",
        "Crema pasticcera",
        "Uovo (per spennellare)",
        "Zucchero a velo (facoltativo)"
      ],
      "procedure": "Preriscaldare il forno a 200°C. Stendere la pasta sfoglia e tagliarla in triangoli. Mettere un po' di crema pasticcera su ogni triangolo di pasta sfoglia, quindi arrotolare dalla base verso l'apice. Disporre i croissant su una teglia rivestita con carta da forno, spennellare la superficie con l'uovo sbattuto e infornare. Cuocere per circa 15-20 minuti o fino a quando i croissant sono dorati e gonfi. Se si desidera, spolverare con dello zucchero a velo prima di servire.",
      "prep_time": "30 minuti"
    },
    {
      "id": "9",
      "isFavourite" : "false",
      "title": "Uova alla benedict",
      "category": "Colazione",
      "image": "assets/image_recipes/uova_benedict.jpg",
      "ingredients_list": [
        "Uova",
        "Panini muffin (o altro tipo di pane)",
        "Prosciutto cotto o bacon",
        "Salsa olandese",
        "Aceto bianco",
        "Sale",
        "Pepe"
      ],
      "procedure": "Preparare la salsa olandese mettendo in una ciotola resistente al calore i tuorli d'uovo e l'aceto bianco. Sbattere leggermente. Mettere la ciotola sopra una pentola con acqua bollente (a bagnomaria) e continuare a sbattere fino a quando la salsa inizia a addensarsi. Togliere dal fuoco e continuare a sbattere, aggiungendo lentamente il burro fuso finché la salsa non diventa cremosa. Aggiustare di sale e pepe. Tostare i panini muffin e cuocere il prosciutto cotto o il bacon in una padella fino a renderlo croccante. Portare a ebollizione una pentola d'acqua leggermente salata e abbassare il fuoco. Rompere delicatamente le uova nell'acqua e cuocere per circa 3-4 minuti per ottenere uova ben cotte ma con il tuorlo morbido. Scolare le uova con un mestolo forato. Per assemblare, mettere un pezzo di prosciutto o bacon su ogni metà del panino muffin, quindi posizionare un uovo sopra e coprire con la salsa olandese. Servire calde.",
      "prep_time": "20 minuti"
    },
    {
      "id": "10",
      "isFavourite" : "true",
      "title": "Bowl di yogurt alla frutta fresca e cereali",
      "category": "Colazione",
      "image": "assets/image_recipes/bowl_frutta.jpg",
      "ingredients_list": [
        "Yogurt greco",
        "Frutta fresca (fragole, mirtilli, banane, ecc.)",
        "Muesli o cereali integrali",
        "Miele o sciroppo d'acero",
        "Noci o mandorle (facoltativo)"
      ],
      "procedure": "In una ciotola capiente, mettere lo yogurt greco. Lavare e tagliare la frutta fresca a pezzetti e aggiungerla sopra lo yogurt. Cospargere con muesli o cereali integrali. Se desiderato, aggiungere noci o mandorle tritate. Terminare con un filo di miele o sciroppo d'acero. Mescolare delicatamente e gustare subito.",
      "prep_time": "5 minuti"
    },
    {
      "id": "11",
      "isFavourite" : "false",
      "title": "Bruschette al pomodoro",
      "category": "Antipasti",
      "image": "assets/image_recipes/bruschetta.jpg",
      "ingredients_list": [
        "Pane rustico",
        "Pomodori maturi",
        "Aglio",
        "Basilico fresco",
        "Olio extravergine d'oliva",
        "Sale",
        "Pepe"
      ],
      "procedure": "Tagliare il pane a fette spesse e tostarle leggermente. Tagliare i pomodori a cubetti e condire con aglio tritato, basilico fresco, olio extravergine d'oliva, sale e pepe. Distribuire il condimento sulle fette di pane tostate. Servire immediatamente.",
      "prep_time": "15 minuti"
    },
    {
      "id": "12",
      "isFavourite" : "false",
      "title": "Carpaccio di manzo",
      "category": "Antipasti",
      "image": "assets/image_recipes/carpaccio.jpg",
      "ingredients_list": [
        "Fettine di manzo",
        "Rucola",
        "Scaglie di parmigiano",
        "Olio extravergine d'oliva",
        "Aceto balsamico",
        "Sale",
        "Pepe"
      ],
      "procedure": "Disporre le fettine di manzo su un piatto da portata. Condire con olio extravergine d'oliva, aceto balsamico, sale e pepe. Guarnire con foglie di rucola e scaglie di parmigiano. Servire freddo.",
      "prep_time": "10 minuti"
    },
    {
      "id": "13",
      "isFavourite" : "false",
      "title": "Insalata di mare",
      "category": "Antipasti",
      "image": "assets/image_recipes/insalata_mare.jpg",
      "ingredients_list": [
        "Frutti di mare misti (cozze, vongole, gamberetti)",
        "Pomodorini ciliegia",
        "Prezzemolo",
        "Aglio",
        "Olio extravergine d'oliva",
        "Limone",
        "Sale",
        "Pepe"
      ],
      "procedure": "Lessare i frutti di mare in acqua bollente salata finché saranno cotti. Scolarli e lasciarli raffreddare. Tagliare i pomodorini a metà. Tritare finemente il prezzemolo e l'aglio. In una ciotola grande, mescolare i frutti di mare con i pomodorini, il prezzemolo e l'aglio. Condire con olio extravergine d'oliva, succo di limone, sale e pepe. Servire freddo.",
      "prep_time": "20 minuti"
    },
    {
      "id": "14",
      "isFavourite" : "false",
      "title": "Crostini con pate di olive",
      "category": "Antipasti",
      "image": "assets/image_recipes/crostini_olive.jpg",
      "ingredients_list": [
        "Pane croccante",
        "Olive nere denocciolate",
        "Acciughe sott'olio",
        "Capperi",
        "Olio extravergine d'oliva",
        "Sale",
        "Pepe"
      ],
      "procedure": "Frullare le olive nere, le acciughe sott'olio e i capperi fino a ottenere una crema omogenea. Aggiungere olio extravergine d'oliva, sale e pepe secondo il proprio gusto. Tostare le fette di pane croccante e spalmare sopra la pate di olive. Servire come antipasto.",
      "prep_time": "15 minuti"
    },
    {
      "id": "15",
      "isFavourite" : "true",
      "title": "Frittelle di zucchine",
      "category": "Antipasti",
      "image": "assets/image_recipes/frittelle.jpg",
      "ingredients_list": [
        "Zucchine",
        "Farina",
        "Uova",
        "Parmigiano grattugiato",
        "Prezzemolo",
        "Aglio",
        "Sale",
        "Pepe",
        "Olio per friggere"
      ],
      "procedure": "Grattugiare le zucchine e strizzarle per eliminare l'acqua in eccesso. In una ciotola, mescolare le zucchine grattugiate con farina, uova, parmigiano grattugiato, prezzemolo tritato, aglio tritato, sale e pepe. Scaldate abbondante olio in una padella. Con un cucchiaio, prendere un po' di impasto e friggerlo fino a doratura da entrambi i lati. Scolare su carta assorbente e servire calde.",
      "prep_time": "25 minuti"
    },
    {
      "id": "16",
      "isFavourite" : "false",
      "title": "Pollo al limone",
      "category": "Secondi",
      "image": "assets/image_recipes/pollo_limone.jpg",
      "ingredients_list": [
        "Petto di pollo",
        "Limoni",
        "Burro",
        "Farina",
        "Brodo di pollo",
        "Prezzemolo",
        "Sale",
        "Pepe"
      ],
      "procedure": "Tagliare il petto di pollo a fettine sottili e infarinarle leggermente. In una padella, far rosolare il pollo con il burro fino a doratura. Aggiungere il succo di limone e il brodo di pollo. Cuocere a fuoco medio fino a quando il pollo è cotto e la salsa si è addensata leggermente. Aggiustare di sale e pepe, spolverare con prezzemolo tritato e servire caldo.",
      "prep_time": "30 minuti"
    },
    {
      "id": "17",
      "isFavourite" : "false",
      "title": "Filetto di branzino al forno",
      "category": "Secondi",
      "image": "assets/image_recipes/branzino.jpg",
      "ingredients_list": [
        "Filetti di branzino",
        "Limone",
        "Aglio",
        "Rosmarino",
        "Olio extravergine d'oliva",
        "Sale",
        "Pepe"
      ],
      "procedure": "Preriscaldare il forno a 200°C. Adagiare i filetti di branzino su una teglia rivestita con carta forno. Condire con sale, pepe, aglio tritato e rosmarino fresco. Spremere il succo di limone sopra i filetti e irrorare con un filo d'olio extravergine d'oliva. Cuocere in forno per circa 15-20 minuti o fino a quando il pesce è cotto e la superficie è dorata. Servire caldo.",
      "prep_time": "25 minuti"
    },
    {
      "id": "18",
      "isFavourite" : "false",
      "title": "Tagliata di manzo",
      "category": "Secondi",
      "image": "assets/image_recipes/tagliata.jpg",
      "ingredients_list": [
        "Bistecca di manzo",
        "Rosmarino",
        "Aglio",
        "Olio extravergine d'oliva",
        "Sale",
        "Pepe"
      ],
      "procedure": "Preriscaldare la griglia o una padella antiaderente. Condire la bistecca con sale, pepe, aglio tritato e rosmarino fresco. Spennellare leggermente con olio extravergine d'oliva. Cuocere la bistecca sulla griglia o nella padella ben calda per circa 3-4 minuti per lato per una cottura al sangue, o più a lungo se si preferisce più cotta. Far riposare la bistecca per qualche minuto prima di tagliarla a fette sottili. Servire calda.",
      "prep_time": "20 minuti"
    },
    {
      "id": "19",
      "isFavourite" : "true",
      "title": "Polpette di melanzane",
      "category": "Secondi",
      "image": "assets/image_recipes/polpette_melanzane.jpg",
      "ingredients_list": [
        "Melanzane",
        "Pane grattugiato",
        "Parmigiano grattugiato",
        "Uova",
        "Aglio",
        "Prezzemolo",
        "Sale",
        "Pepe",
        "Olio per friggere"
      ],
      "procedure": "Tagliare le melanzane a cubetti e cuocerle al vapore fino a quando sono tenere. Scolare le melanzane e schiacciarle con una forchetta per eliminare l'acqua in eccesso. In una ciotola, mescolare le melanzane schiacciate con pane grattugiato, parmigiano grattugiato, uova sbattute, aglio tritato, prezzemolo tritato, sale e pepe. Formare delle polpette con le mani e friggerle in abbondante olio fino a doratura. Scolare su carta assorbente e servire calde.",
      "prep_time": "40 minuti"
    },
    {
      "id": "20",
      "isFavourite" : "false",
      "title": "Cotoletta alla milanese",
      "category": "Secondi",
      "image": "assets/image_recipes/cotoletta_milanese.jpg",
      "ingredients_list": [
        "Fettine di carne (vitello, maiale o pollo)",
        "Uova",
        "Pangrattato",
        "Farina",
        "Burro",
        "Limone",
        "Sale",
        "Pepe"
      ],
      "procedure": "Battere leggermente le fettine di carne. Passarle prima nella farina, poi nell'uovo sbattuto e infine nel pangrattato. Farle cuocere in padella con abbondante burro fino a doratura. Servire con fette di limone, sale e pepe.",
      "prep_time": "30 minuti"
    },
    {
      "id": "21",
      "isFavourite" : "false",
      "title": "Cheesecake alle fragole",
      "category": "Dolci",
      "image": "assets/image_recipes/cheesecake.jpg",
      "ingredients_list": [
        "Biscotti digestive",
        "Burro fuso",
        "Formaggio cremoso",
        "Zucchero",
        "Vaniglia",
        "Uova",
        "Panna montata",
        "Fragole"
      ],
      "procedure": "Tritare i biscotti digestive e mescolarli con il burro fuso. Pressare il composto di biscotti sul fondo di una teglia a cerniera, livellando bene. Mettere in frigorifero per 30 minuti. Nel frattempo, preparare la crema: sbattere il formaggio cremoso con lo zucchero e la vaniglia fino a ottenere una crema liscia. Aggiungere le uova una alla volta, mescolando bene dopo ogni aggiunta. Infine, incorporare delicatamente la panna montata. Versare la crema sulla base di biscotti e cuocere in forno preriscaldato a 160°C per circa 50-60 minuti o fino a quando il centro è leggermente tremolante. Lasciare raffreddare completamente e mettere in frigorifero per almeno 4 ore, meglio se tutta la notte. Prima di servire, decorare con fragole fresche.",
      "prep_time": "30 minuti"
    },
    {
      "id": "22",
      "isFavourite" : "false",
      "title": "Crostata di frutta",
      "category": "Dolci",
      "image": "assets/image_recipes/crostata_frutta.jpg",
      "ingredients_list": [
        "Farina",
        "Burro",
        "Zucchero",
        "Uova",
        "Marmellata di albicocche",
        "Frutta fresca mista (fragole, mirtilli, pesche, ecc.)"
      ],
      "procedure": "In una ciotola, lavorare il burro a temperatura ambiente con lo zucchero fino a ottenere una crema. Aggiungere le uova una alla volta, mescolando bene dopo ogni aggiunta. Infine, incorporare la farina fino a ottenere un impasto omogeneo. Avvolgere l'impasto nella pellicola trasparente e metterlo in frigorifero per almeno 30 minuti. Stendere l'impasto su una teglia per crostate e bucherellare il fondo con una forchetta. Cuocere in forno preriscaldato a 180°C per circa 15-20 minuti o fino a doratura. Una volta raffreddata, spalmare la marmellata di albicocche sulla base della crostata. Decorare con la frutta fresca tagliata a pezzetti.",
      "prep_time": "60 minuti"
    },
    {
      "id": "23",
      "isFavourite" : "false",
      "title": "Mousse al cioccolato",
      "category": "Dolci",
      "image": "assets/image_recipes/mousse_ciocco.jpg",
      "ingredients_list": [
        "Cioccolato fondente",
        "Uova",
        "Zucchero",
        "Panna montata"
      ],
      "procedure": "Fondere il cioccolato fondente a bagnomaria o nel microonde. Separare gli albumi dai tuorli. In una ciotola, sbattere i tuorli con lo zucchero fino a ottenere un composto chiaro e spumoso. Aggiungere il cioccolato fuso ai tuorli e mescolare bene. Montare gli albumi a neve ferma e incorporarli delicatamente al composto di cioccolato. Infine, incorporare la panna montata con movimenti delicati dal basso verso l'alto. Distribuire la mousse in coppette e mettere in frigorifero per almeno 2 ore prima di servire. Decorare a piacere con scaglie di cioccolato o panna montata.",
      "prep_time": "30 minuti"
    },
    {
      "id": "24",
      "isFavourite" : "false",
      "title": "Cannoli siciliani",
      "category": "Dolci",
      "image": "assets/image_recipes/cannoli_siciliani.jpg",
      "ingredients_list": [
        "Farina",
        "Zucchero",
        "Cacao in polvere",
        "Cannella",
        "Marsala",
        "Aceto bianco",
        "Burro",
        "Olio per friggere",
        "Ricotta",
        "Zucchero a velo",
        "Scorza d'arancia candita",
        "Gocce di cioccolato"
      ],
      "procedure": "In una ciotola, mescolare la farina con lo zucchero, il cacao in polvere e la cannella. Aggiungere il Marsala e l'aceto bianco e impastare fino a ottenere una consistenza elastica. Avvolgere l'impasto in pellicola trasparente e lasciarlo riposare in frigorifero per almeno 30 minuti. Stendere l'impasto su una superficie infarinata fino a ottenere una sfoglia sottile. Tagliare la sfoglia in dischi e avvolgerli attorno a tubi di metallo per cannoli. In una pentola, scaldare l'olio per friggere e cuocere i cannoli fino a doratura. Scolarli su carta assorbente e lasciarli raffreddare. Nel frattempo, mescolare la ricotta con lo zucchero a velo e le gocce di cioccolato. Riempire i cannoli con la crema di ricotta e guarnire con scorza d'arancia candita. Servire freschi e croccanti.",
      "prep_time": "60 minuti"
    },
    {
      "id": "25",
      "isFavourite" : "true",
      "title": "Tiramisù",
      "category": "Dolci",
      "image": "assets/image_recipes/tiramisu.jpg",
      "ingredients_list": [
        "Savoiardi",
        "Caffè",
        "Mascarpone",
        "Uova",
        "Zucchero"
      ],
      "procedure": "Preparare il caffè e farlo raffreddare. In una ciotola, sbattere le uova con lo zucchero fino a ottenere una crema. Aggiungere il mascarpone e mescolare bene. Inzuppare i savoiardi nel caffè e alternarli con strati di crema. Spolverizzare con cacao amaro. Lasciar riposare in frigorifero per almeno 4 ore prima di servire.",
      "prep_time": "30 minuti"
    },
    {
      "id": "26",
      "isFavourite" : "false",
      "title": "Pizza Margherita",
      "category": "Lievitati",
      "image": "assets/image_recipes/pizza.jpg",
      "ingredients_list": [
        "Farina",
        "Acqua",
        "Lievo di birra",
        "Sale",
        "Pomodoro",
        "Mozzarella",
        "Basilico"
      ],
      "procedure": "Preparare l'impasto mescolando la farina con l'acqua, il lievito e il sale. Lasciar lievitare fino al raddoppio del volume. Stendere l'impasto su una teglia da pizza, aggiungere il pomodoro, la mozzarella e il basilico. Infornare a temperatura alta fino a quando la pizza è dorata.",
      "prep_time": "1 ora"
    },
    {
      "id": "27",
      "isFavourite" : "false",
      "title": "Focaccia",
      "category": "Lievitati",
      "image": "assets/image_recipes/focaccia.jpg",
      "ingredients_list": [
        "Farina",
        "Acqua",
        "Lievo di birra",
        "Sale",
        "Olio extravergine d'oliva",
        "Rosmarino fresco",
        "Sale grosso"
      ],
      "procedure": "Mescolare la farina con il lievito di birra, il sale e l'acqua tiepida. Lavorare bene l'impasto fino a quando diventa morbido ed elastico. Coprire e lasciar lievitare fino al raddoppio del volume. Stendere l'impasto su una teglia da forno, spolverare con sale grosso, rosmarino fresco tritato e un filo d'olio extravergine d'oliva. Fare dei buchi con le dita sulla superficie. Lasciar lievitare ancora per circa 30 minuti. Cuocere in forno preriscaldato a 200°C per circa 20-25 minuti o fino a doratura. Servire calda o a temperatura ambiente.",
      "prep_time": "120 minuti"
    },
    {
      "id": "28",
      "isFavourite" : "false",
      "title": "Pane ai cereali",
      "category": "Lievitati",
      "image": "assets/image_recipes/pane_cereali.jpg",
      "ingredients_list": [
        "Farina",
        "Acqua",
        "Lievo di birra",
        "Sale",
        "Cereali misti (avena, grano saraceno, segale, ecc.)",
        "Semi di girasole",
        "Semi di lino",
        "Semi di sesamo"
      ],
      "procedure": "In una ciotola grande, mescolare la farina con il lievito di birra e il sale. Aggiungere gradualmente l'acqua tiepida e impastare fino a ottenere un composto omogeneo ed elastico. Coprire e lasciar lievitare fino al raddoppio del volume. Aggiungere i cereali misti e i semi alla pasta lievitata e lavorare l'impasto fino a quando sono ben distribuiti. Formare una pagnotta e metterla in una teglia da forno leggermente infarinata. Coprire e lasciar lievitare ancora per circa 30-40 minuti. Preriscaldare il forno a 200°C. Prima di infornare, spolverare la superficie del pane con un po' di farina e praticare dei tagli superficiali con un coltello affilato. Cuocere in forno preriscaldato per circa 30-40 minuti o fino a doratura. Sfornare e lasciar raffreddare su una griglia prima di tagliare a fette.",
      "prep_time": "150 minuti"
    },
    {
      "id": "29",
      "isFavourite" : "true",
      "title": "Panzerotti",
      "category": "Lievitati",
      "image": "assets/image_recipes/panzerotti.jpg",
      "ingredients_list": [
        "Farina",
        "Acqua",
        "Lievo di birra",
        "Sale",
        "Olio extravergine d'oliva",
        "Pomodori",
        "Mozzarella",
        "Origano",
        "Sale",
        "Pepe"
      ],
      "procedure": "Preparare l'impasto mescolando la farina con l'acqua, il lievito di birra e il sale. Lavorare bene l'impasto fino a quando diventa liscio ed elastico. Coprire e lasciar lievitare fino al raddoppio del volume. Dividere l'impasto in porzioni e stenderle con il mattarello su una superficie infarinata. Farcire metà di ogni disco di pasta con pomodori a fette, mozzarella a dadini, origano, sale e pepe. Richiudere i panzerotti e sigillare i bordi con le dita o con una forchetta. Friggere i panzerotti in olio extravergine d'oliva caldo finché sono dorati e croccanti. Scolarli su carta assorbente per eliminare l'olio in eccesso e servirli caldi.",
      "prep_time": "90 minuti"
    },
    {
      "id": "30",
      "isFavourite" : "false",
      "title": "Gnocco Fritto",
      "category": "Lievitati",
      "image": "assets/image_recipes/gnocco_fritto.jpg",
      "ingredients_list": [
        "Farina",
        "Acqua",
        "Lievo di birra",
        "Sale",
        "Olio per friggere"
      ],
      "procedure": "In una ciotola grande, mescolare la farina con il lievito di birra e il sale. Aggiungere gradualmente l'acqua tiepida e impastare fino a ottenere un composto omogeneo ed elastico. Coprire e lasciar lievitare fino al raddoppio del volume. Trasferire l'impasto su una superficie infarinata e stenderlo con il mattarello fino a ottenere una sfoglia spessa circa mezzo centimetro. Tagliare la sfoglia in rettangoli o quadrati. Scaldare abbondante olio in una pentola e friggere gli gnocchi fritti fino a quando sono dorati e gonfi. Scolarli su carta assorbente per eliminare l'eccesso di olio. Servire gli gnocchi fritti caldi come contorno o accompagnamento.",
      "prep_time": "60 minuti"
    }
  ]
}
''';
