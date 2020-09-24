//
//  ViewController.swift
//  decrypt
//
//  Created by Guilherme Rangel on 23/09/20.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    var cipherText = ""
    let alphabet = Alphabet.alphabet
    var text:[String] = []
    var displacementTrigram:[String:[Int]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        //le o arquivo com o texto cifrado
        cipherText = readFile(fileName: "text").uppercased()
        //aplica o método de kasinski para obter o possivel tamanho da chave
        for t in cipherText{
            text.append(String(t))
        }
       let last = kasinsk(text: text, tamKey: 2)
        
        displacementTrigram = last.last!
        
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
            //evita que trigrams se repita a frente
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
    
    
    
    
    
    
    
    
    
    
    
}
