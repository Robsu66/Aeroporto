public class VooTriggerAfterInsert {
    public static boolean isAfterInsert = false;
    public static void calculaDistanciaHelper(Set<Id> voosId){
        CalculaDistanciaHelper.atualizaDistancia(voosId);
    }
}