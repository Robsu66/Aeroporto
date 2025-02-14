public with sharing class CalculaDistanciaHelper {
    public static void atualizaDistancia(Set<Id> voosId){
        
        List<Voo__c> voosParaAtualizar = new List<Voo__c>();
        List<Voo__c> listaDeVoos = new List<Voo__c>();

        listaDeVoos = [SELECT Id, Chegada__r.Localizacao__Latitude__s, Chegada__r.Localizacao__Longitude__s, 
                      Partida__r.Localizacao__Latitude__s, Partida__r.Localizacao__Longitude__s
                      FROM Voo__c WHERE Id IN: voosId];

        for(Voo__c v : listaDeVoos){
            Decimal distancia = calculateDistance(
                    v.Partida__r.Localizacao__Latitude__s,
                    v.Partida__r.Localizacao__Longitude__s,
                    v.Chegada__r.Localizacao__Latitude__s,
                    v.Chegada__r.Localizacao__Longitude__s
                );
                v.Distancia__c = distancia;
                voosParaAtualizar.add(v);
            
        }
        if(!voosParaAtualizar.isEmpty()){
            update voosParaAtualizar;
        }
    }

    public static Decimal calculateDistance(Decimal latitude1, Decimal longitude1, Decimal latitude2, Decimal longitude2) {
        Integer earthRadius = 6371 * 1000; // in meters

        // Transform coordinates from degrees to radians
        Decimal latitudeRadians1 = latitude1 * Math.PI/180;
        Decimal latitudeRadians2 = latitude2 * Math.PI/180;
        
        // Latitude and longitude differences in radians
        Decimal latitudeDelta = (latitude2 - latitude1) * Math.PI/180;
        Decimal longitudeDelta = (longitude2 - longitude1) * Math.PI/180;
        Decimal a = Math.sin(latitudeDelta/2) * Math.sin(latitudeDelta/2) +
        Math.cos(latitudeRadians1) * Math.cos(latitudeRadians2) *
        Math.sin(longitudeDelta/2) * Math.sin(longitudeDelta/2);
        Decimal arc = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        Decimal distance = earthRadius * arc; // in metres

        return distance;
    }
}