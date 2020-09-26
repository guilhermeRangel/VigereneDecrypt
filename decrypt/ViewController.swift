//
//  ViewController.swift
//  decrypt
//
//  Created by Guilherme Rangel on 23/09/20.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    let alphabet = AlphabetClass.alphabet
    
    var cipherText = String()
    var displacementTrigram:[String:[Int]] = [:]
    var textSplited:[String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        //le o texto do arquivo text
        cipherText = readFile(fileName: "text").uppercased()
        //separa por letra
        textSplited = splitStr(texT: cipherText)
        //aplica a tecnica de kasinski para presupor o tamanho da chave
        //        let result = kasinsk(text: textSplited, tamKey: 2)
        //        //agrupamento de trigramas com sua frequencia de aparicoes e posicoes
        //        displacementTrigram = result.last!
        
        //        let possibility = verifyPossibleKeyTam(l: displacementTrigram, tamKey: 2)
        //possiveis tamanho de chave
        //        print(possibility)
        let listSplited = splitTextWithKTamKey(tamKey: 7)
        var mostOccurringCharacter = calcIndiceConicidencia(list: listSplited)
        mostOccurringCharacter.removeFirst()
        let caracterPopular = descriptKeyWithFrequency(list: mostOccurringCharacter)
        
     
    }
    
        
    
    func descriptKeyWithFrequency(list: [[Dictionary<String, Int>.Element]]) -> [[String:Int]]{
        var objList:[[String:Int]] = [[:]]
        
        for i in 0...list.count{
            var count = 0
            if i != list.count{
                for (key, value) in list[i]{
                    if count < 4{
                        objList[i].updateValue(value, forKey: key)
                    }
                    count+=1
                }
                objList.append([:])
            }else{
                objList.removeLast()
                return objList
            }
        
        }
        return objList
    }
    func calcIndiceConicidencia(list: [[String]]) -> [[Dictionary<String, Int>.Element]]{
        var mostFrequent:[[Dictionary<String, Int>.Element]] = [[]]
        
        for i in list{
            let arr = i
            var counts: [String: Int] = [:]
            arr.forEach { counts[$0, default: 0] += 1 }
            var listOrdened = counts.sorted(by: {
                $0.1 > $1.1
            })
            mostFrequent.append(listOrdened)
        }
        return mostFrequent
    }
    // separa uma string
    func splitStr(texT: String) -> [String]{
        var textStr:[String] = []
        for txt in texT{
            textStr.append(String(txt))
        }
        return textStr
    }
    func verifyPossibleKeyTam(l: [String : [Int]], tamKey: Int) -> [Int:Int]{
        var keyEstatics:[Int:Int] = [:]
        var displacement:[Int] = []
        
        //ordena a lista com os que tem mais ocorrencias para que fique no topo
        let list = l.sorted(by: {
            $0.1.count > $1.1.count
        })
        
        //testa até o tamanho da metade do tamanho do texto supondo que a chave é a do tamanho do texto
        for k in tamKey...cipherText.count/2{
            //percorre a lista para cada chave
            for (key, commomDivisor) in list{
                //percorre valores referente a todas as repeticoes
                for i in 0...commomDivisor.count-1{
                    //compara para cada um verificando se é multiplo
                    if commomDivisor[i] % k == 0 && commomDivisor.count > 2 {
                        displacement.append(commomDivisor[i])
                    }else{
                        break
                    }
                }
                
                // teste se todos sao divisiveis pelo mesmo divisor comum
                if displacement.count == commomDivisor.count{
                    //verifico se esse divisor ja existe
                    if keyEstatics.keys.contains(commomDivisor.count){
                        //uso essa funcao para pega-lo dado que a chave é unica
                        var aux = keyEstatics.filter { x in
                            //sempre sera satisfeita
                            x.value >= 1
                            
                        }
                        
                        keyEstatics.updateValue(aux.values.first!+1, forKey: commomDivisor.count)
                        
                    }else{
                        
                        keyEstatics.updateValue(1, forKey: commomDivisor.count)
                    }
                    
                }
                displacement.removeAll()
            }
        }
        
        return keyEstatics
    }
    func kasinsk(text: [String], tamKey: Int) -> [[String:[Int]]]{
        var trigram = ""
        var strAux = ""
        var displacementTrigram:[String:[Int]] = [:]
        var list:[[String:[Int]]] = [[:]]
        var displacement:[Int] = []
        
        for k in 0...text.count
        {
            //cria o trigram
            for i in k...k+tamKey{
                //evita que saia do array
                if i < text.count{
                    trigram.append(text[i])
                }else{
                    return list
                }
            }
            //evita que trigrams se repitam mais a frente e sejam inseridos na lista novamente
            if list.last!.keys.contains(trigram){
                trigram.removeAll()
            }
            
            var flag = false
            if !trigram.isEmpty {
                //varre a estrutura logo após trigram anterior
                for i in k+tamKey...text.count{
                    //monta o proximo trigram
                    for j in i+1...i+1+tamKey{
                        if j < text.count{
                            strAux.append(text[j])
                        }
                    }
                    
                    //compara se sao iguais
                    if trigram.contains(strAux){
                        flag = true
                        //guarda as posicoes que houve repeticao
                        displacement.append(i+1)
                        displacementTrigram.updateValue(displacement, forKey: trigram)
                    }
                    strAux.removeAll()
                }
                //evita que seja adicionado um trigram sem repeticao
                if flag {
                    list.append(displacementTrigram)
                    flag = false
                }
                
                trigram.removeAll()
                displacement.removeAll()
            }
        }
        return list
    }
    func splitTextWithKTamKey(tamKey: Int) -> [[String]]{
        var count = 0
        var list:[String] = []
        var listAll:[[String]] = []
        
        for k in 0...tamKey{
            count = k
            for i in k...textSplited.count-1{
                if i == count{
                    count += tamKey
                    let str = textSplited[i]
                    list.append(str)
                }
            }
            listAll.append(list)
            list.removeAll()
        }
        return listAll
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
