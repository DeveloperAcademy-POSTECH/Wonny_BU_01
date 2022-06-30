//
//  WordView.swift
//  CCC_RandomWord
//
//  Created by kwon ji won on 2022/06/28.
//
import Foundation
import SwiftUI

class WordViewModel : ObservableObject {
    @Published var words:[String] = []
    @Published var selectNum:String
    init(selectNum: String) {
        self.selectNum = selectNum
        Task{
            await fetchData()
        }
    }
    func fetchData() async{
        // create url
        // guard let :
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=\(selectNum)")
        else {
            print("error")
            return
        }
        //fetch
        //do + catch : 에러를 잡기 위해서 사용 _:respinse : 여기선 생략된거다
        do {
            let (data,_) = try await URLSession.shared.data(from:url)
            //decode that data
            if let decodedResponse = try? JSONDecoder().decode([String].self, from: data) {
                //words array에 값을 할당한다.
                //..??? 이건 나도모르겠는데 좀더 레벨업 하면 알겠조?
                //view를 변경할 때는 main thread에서만 가능하다.
                DispatchQueue.main.async {
                    [weak self] in
                    self?.words = decodedResponse
                }
            }
            
        } catch {
            print("err")
        }
    }
}

struct WordView: View {
    @Binding var selectedNumber: String
    @ObservedObject private var viewModel = WordViewModel(selectNum: "1")
    
    init(selectedNumber: Binding<String>) {
        self._selectedNumber = selectedNumber
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.words , id: \.self) { word in
                    Text(word)
                }
            }
        }
    }
}
    
    
    struct WordView_Previews: PreviewProvider {
        static var previews: some View {
            WordView(selectedNumber: .constant("1"))
        }
    }
