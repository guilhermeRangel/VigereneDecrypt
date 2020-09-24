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
    var displacement:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //le o arquivo com o texto cifrado
        cipherText = readFile(fileName: "text").uppercased()
        //aplica o método de kasinski para obter o possivel tamanho da chave
        for t in cipherText{
            text.append(String(t))
        }
        displacement = kasinsk(text: text, tamKey: 2)
        print(displacement)
    }
    
    
    func kasinsk(text: [String], tamKey: Int) -> [Int]{
        var strKey = ""
        var strAux = ""
        
        var displacement:[Int] = []
        
        
        //cria uma string com tamanho fixo
        for i in 0...tamKey{
            strKey.append(text[i])
        }
        
        //percorre todo o arquivo procurando ocorrencias iguais de strKey
        for i in tamKey...text.count{
            //sequencialmente pega os proximos n caracteres
            for j in i+1...i+tamKey+1{
                if j < text.count{
                    strAux.append(text[j])
                }

            }
            //verifica se a strKey é igual a uma string de mesmo tamanho
            if strKey.contains(strAux){
                //guarda a posicao que foi encontrado para calcular o deslocamento
                displacement.append(i+1-tamKey) //passa a posicao inicial da string igual
            }
            strAux.removeAll()
    }
        return displacement
}

}
