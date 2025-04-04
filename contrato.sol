// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract jokenpo{
//variaveis de sistema para armazenar as jogadas da 'rodada' em questao -- mapping por endereço - indice = rodada

uint public rodadaAtual;

address public dono;

address public jogador1;

address public jogador2;

uint[] public listaJogadasJogador1;

uint[] public listaJogadasJogador2;

uint[] public listaResultados; // 0 para empate, 1 para o jogador 1 e 2 para o jogador 2
//fazer mapping por endereço e ele aponta para uma lista de strings para cada pessoa, sendo cada string a jogada da pessoa por rodada


//colocando construct para setar o dono quando iniciar o smart
constructor(){
    dono = msg.sender;
    rodadaAtual = 0; //começa em zero
}
// set de jogador 1 e 2 (apenas o dono do contrato pode modificar isso)

function ver_regras() public view returns(string memory){
    return "para escolher sua jogada, use a funcao 'setJogada'. Dicionario das jogadas: use 1 para (pedra), use 2 para (papel), use 3 para (tesoura)";
}

function setJogadoresCredenciados(address _jogador1, address _jogador2) public{
    //verificando se é o dono msm chamando a fucnao
    require(msg.sender == dono, "voce nao e o dono, so ele pode chamar essa funcao para setar os jogadores");

    //passando os valores dos endereços que o dono colocou como jogadores

    jogador1 = _jogador1;

    jogador2 = _jogador2;
}

//definir jogador 1 e jogador 2 (deixa address vazio e na hora define), ai uma lista para o jogador1 e uma lista para o jogador 2, e uma lista de resultados

//funcao para registrar as jogadas da rodada em questão (na lisa do jogador 1 e na lista do jogador 2), usando um contador de rodadas
function setJogadas (uint jogada)public {
    //verificando se quem ta chamando é um dos jogadores setados
    require(jogador1 == msg.sender || jogador2 == msg.sender, "voce nao e um dos jogadores setado");


    //fazendo a jogada
    uint jogadaPartida = jogada;

// vendo quem é primeiro
    if (jogador1 == msg.sender){

        if(jogadaPartida == 1){ //pedra
            listaJogadasJogador1.push(1);
        }
        else if(jogadaPartida == 2){ //papel
            listaJogadasJogador1.push(2);
        }
        else if(jogadaPartida == 3){ //tesoura
            listaJogadasJogador1.push(3);
        }
    }

    if (jogador2 == msg.sender){

         if(jogadaPartida == 1){ //pedra
            listaJogadasJogador2.push(1);
        }
        else if(jogadaPartida == 2){ //papel
            listaJogadasJogador2.push(2);
        }
        else if(jogadaPartida == 3){ //tesoura
            listaJogadasJogador2.push(3);
        }
        
    }

  
}

//funcao para 'iniciar' a rodada

function iniciar_rodada() public{


    //verificando se as duas listas, para o indice da rodada atual, tem algum valor

    //verificando se é algum dos dois jogadores que tá dando start

    require((jogador1 == msg.sender && jogador2 == address(0)) || (msg.sender == dono),"voce nao e um dos jogadores setado ou o dono do contrato"); // se nao, vai dar erro

    //batendo os resultados, para a rodada atual.

    //fazendo as comparações e vendo quem vai ganhar
    if (listaJogadasJogador1[rodadaAtual] == listaJogadasJogador2[rodadaAtual]) { //se o valor da jogada do primeiro jogador for igual ao que do segundo, empata o jogo
        listaResultados.push(0); //sobe o resultado de impate
    }

    //1 - pedra
    //2 - papel
    //3 - tesoura

    //case 1 - jogador 1 o centro -- casos olhando para ele

    //case em que ele taca 1 - pedra

    else if(listaJogadasJogador1[rodadaAtual] == 1 && listaJogadasJogador2[rodadaAtual] == 2 ){
        listaResultados.push(2); //sobe o resultado que o 1 ganhou, porque ele ganhou pelo centro (pedra)
    }else if((listaJogadasJogador1[rodadaAtual] == 1 && listaJogadasJogador2[rodadaAtual] == 3)){ 
        listaResultados.push(1);
    }
    else if ((listaJogadasJogador1[rodadaAtual] == 2 && listaJogadasJogador2[rodadaAtual] == 1)){ 
        listaResultados.push(1);}
    else if ((listaJogadasJogador1[rodadaAtual] == 2 && listaJogadasJogador2[rodadaAtual] == 3)){ 
        listaResultados.push(2);}

    else if ((listaJogadasJogador1[rodadaAtual] == 3 && listaJogadasJogador2[rodadaAtual] == 1)){ 
        listaResultados.push(2);}
    else if ((listaJogadasJogador1[rodadaAtual] == 3 && listaJogadasJogador2[rodadaAtual] == 2)){ 
        listaResultados.push(1);}

      //adicionando 1 na rodada;
    rodadaAtual = rodadaAtual + 1;
}

function verResultadoPartida () view public returns(string memory){
    //criando dicionario para cada caso de resultado (0 - retornar string empate), (1- retonar string 'jogador 1 ganhou'), (2 - retornar string 'jogador 2 ganhou')

    uint resultado = listaResultados[rodadaAtual];

    string memory resultadostring;

    if(resultado == 0){
        resultadostring = "empate";    
        return resultadostring;
    }else if (resultado == 1){
        resultadostring = "jogador 1 ganhou";
        return resultadostring;

        
    }
    else if (resultado == 2){
        resultadostring = "jogador 2 ganhou";
        return resultadostring;
    }


}

function verRodadasAnteriores () public view returns(uint[] memory){

    return listaResultados;

}

function verJogadaPartida () public view returns(uint){ //quando quiser pegar uma jogada, retornara o valor dela
     return listaJogadasJogador1[rodadaAtual];//pegando a jogada de cada jogadores por rodada (criado no set da jogada)
     return listaJogadasJogador2[rodadaAtual];
}


        


     

     
    //adicionando essas jogadas em cada lista do jogador
   


//funcao para ver o resultado

//funcao para ver as jogadas anteriores por jogador e os resultados anteriores e estatistica para a proxima

//


}

