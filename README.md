# WOD-Timer

![naruto-shippuden-op](https://github.com/BOLTB0X/WOD-Timer-app/assets/83914919/46390356-0983-4b42-917b-5a44cbbffbd4)

## 개발 환경 및 기술 스택

| 항목      | 내용                                                   |
| --------- | ------------------------------------------------------ |
| 개발 환경 | Xcode 14.2, iOS 15.0                                   |
| 주요 기술 | SwiftUI, Combine, WidgetKit, ActivityKit, AVFoundation |
| 개발 언어 | Swift                                                  |

## Current - ing

<p align="center">
  <table style="width:100%; text-align:center; border-spacing:20px;">
    <tr>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%ED%83%80%EC%9D%B4%EB%A8%B8.gif?raw=true" 
             alt="image 1" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%EC%9A%B4%EB%8F%99%EB%A3%A8%ED%94%84%20%EC%84%A4%EC%A0%95.gif?raw=true" 
             alt="image 1" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EB%94%94%ED%85%8C%EC%9D%BC%EC%8A%A4%ED%86%B1%EC%9B%8C%EC%B9%98.gif?raw=true" 
             alt="image 2" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
    </tr>
    <tr>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      Simple timer
      </p>
      </td>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      Detail timer
      </p>
      </td>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      Stopwatch
      </p>
      </td>
    </tr>
  </table>
</p>

<p align="center">
  <table style="width:100%; text-align:center; border-spacing:20px;">
    <tr>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EB%8B%A4%EC%9D%B4%EB%82%98%EB%AF%B9%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C%202.gif?raw=true" 
             alt="image 1" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EB%8B%A4%EC%9D%B4%EB%82%98%EB%AF%B9%EC%95%84%EC%9D%BC%EB%9E%9C%EB%93%9C_%ED%99%95%EC%9E%A5.gif?raw=true" 
             alt="image 1" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
      <td style="text-align:center; vertical-align:middle;">
        <p align="center">
        <img src="https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EC%9E%A0%EA%B8%88%ED%99%94%EB%A9%B43.gif?raw=true" 
             alt="image 2" 
             style="width:200px; height:400px; object-fit:contain; border:1px solid #ddd; border-radius:4px;"/>
        </p>
      </td>
    </tr>
    <tr>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      Background
      </p>
      </td>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      Dynamic island
      </p>
      </td>
      <td style="text-align:center; font-size:14px; font-weight:bold;">
      <p align="center">
      잠금 화면
      </p>
      </td>
    </tr>
  </table>
</p>

## 핵심 기능

<details>
<summary> Timer 구현 핵심 코드 </summary>
   <br/>

| Timer                                                                                                                |
| -------------------------------------------------------------------------------------------------------------------- |
| ![timer](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%ED%83%80%EC%9D%B4%EB%A8%B8.gif?raw=true) |

<br/>

1. **Propertys**

   ```swift
   // MARK: - SimpleViewModel
   class SimpleViewModel: InputManager {
       static let shared = SimpleViewModel() // 싱글톤 패턴

       // MARK: - 프로퍼티s
       // ...
       // etc
       @Published var simpleCompletion: Date? // 완료일
       @Published var simpleDisplay: Int = 0

       // MARK: - Timer
       @Published var simpleTmRounds: [SimpleRound] = [] // 심플 타이머루틴 배열
       @Published var simpleTotalTime:Int = 0 // 심플 루틴 배열의 총 시간
       @Published var simpleTmRoundIdx: Int? //
       @Published var simpleTimerCompletion: String = "X" // 완료일
       @Published var simpleTimerHistory: RoundHistory = RoundHistory() // 히스토리

       // 진행률 -> 타이머
       @Published var simpleUnitProgress: Float = 0.0
       @Published var simpleFullProgress: Float = 0.0

       // 타이머 상태 관련
       @Published var simpleTimerState: TimerState = .cancelled {
           didSet {
               switch simpleTimerState {
               case .cancelled, .completed: // 취소 또는 완료
                   timerCancellable?.cancel()
                   simpleDisplay = 0
                   updateSimpleCompletionDate()

               case .active: // 실행
                   startSimpleTimer()

               case .paused: // 중지
                   pauseSimpleTimer()

               case .resumed: // 재개
                   resumeSimpleTimer()
               } // switch
           } // didSet
       }

       // ...
       // 생략
   }
   ```

   <br/>

2. **Methods**

   ```swift
   // MARK: - SimpleViewModel+Timer: SimpleTimer Control
   // 제어관련 메소드들
   extension SimpleViewModel {
       // MARK: - basic Control
       // ....
       // MARK: - startSimpleTimer
       func startSimpleTimer() {
           guard let idx = simpleTmRoundIdx, idx < simpleTmRounds.count, let currentPhase = simpleRoundPhase else {
               return
           }

           print("타이머 실행")
           print(simpleRoundPhase?.phaseText ?? "??")

           updateTimerPhaseStart(idx: idx, currentPhase: currentPhase)

           DispatchQueue.main.async {
               self.speakingCurrentState()
           }

           updateContentState(currentPhase, idx, simpleDisplay)

           timerCancellable = Timer.publish(every: 1.0, on: .main, in: .common)
               .autoconnect()
               .sink { _ in
                   if self.simpleDisplay > 0 && self.simpleRoundPhase != .preparation {
                       self.simpleTotalTime -= 1
                   }

                   self.simpleDisplay -= 1

                   self.updateContentState(currentPhase, idx, self.simpleDisplay)

                   // 5초 이하일 때 countdown 사운드 재생
                   if self.simpleDisplay <= 5 && self.simpleDisplay > 0 {
                       DispatchQueue.global().async {
                           AVManager.shared.playSound(named: "whistle_counting", fileExtension: "caf")
                       }
                   } else if self.simpleDisplay == 0 {
                       DispatchQueue.global().async {
                           AVManager.shared.playSound(named: "whistle_countComplete", fileExtension: "caf")
                       }
                   }

                   DispatchQueue.main.async {
                       self.updateSimpleUnitProgress()
                }

                if self.simpleDisplay < 0 {
                    self.completedCurrentTimer() // 완료
                }

               } // sink

           return
       }

       // MARK: - completedCurrentTimer
       // 현재 타이머 종료시 다음 단계로 이동
       func completedCurrentTimer() {
           timerCancellable?.cancel()
           simpleTimerState = .completed
           updateSimpleTimerCompletion() // 기록
           simpleUnitProgress = 0.0
           // 다음 라운드 페이즈로 이동
           nextSimpleTimerRoundPhase()
           return
       }

       // MARK: - pauseSimpleTimer
       // 일시 중지
       func pauseSimpleTimer() {
           timerCancellable?.cancel()
           print("일시중지")
           updateSimpleCompletionDate()
           return
       }

        // MARK: - resumeSimpleTimer
        // 재개
        func resumeSimpleTimer() {
           print("재개")
           updateSimpleCompletionDate()
           simpleTimerState = .active
           controlBtn = false
           return
       }

       // MARK: - simpleTimerRestart
       // 재시작
       func simpleTimerRestart() {
           simpleTmRoundIdx = nil
           simpleTotalTime = simpleTmRounds.reduce(0) {$0 + ($1.movement + $1.rest) }
           nextSimpleTimerRound()
           return
       }

       // MARK: - simpleTimerCanclled
       // 타이머 취소
       func simpleTimerCanclled() {
           simpleTimerState = .cancelled
           simpleTmRoundIdx = nil
           controlBtn = false
           simpleUnitProgress = 0
           requestOffLiveActivity()
           return
       }

   // ....

   }
   ```

</details>

<details>
<summary> 운동 제어 컨트롤 바 핵심 코드</summary>
   <br/>

| 앞으로 가기                                                                                                                       | 앞으로 뒤로                                                                                                       | 뒤로 가기 및 다시 시작                                                                                                                                                   |
| --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ![앞으로](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EC%95%9E%EC%9C%BC%EB%A1%9C%EA%B0%80%EA%B8%B01.gif?raw=true) | ![앞뒤](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/before_next%20%ED%98%BC%ED%95%A9.gif?raw=true) | ![뒤로](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/%EB%92%A4%EB%A1%9C%EA%B0%80%EA%B8%B0%20%EB%B0%8F%20%EB%8B%A4%EC%8B%9C%EC%8B%9C%EC%9E%91.gif?raw=true) |

<br/>

1. **Propertys**
   Timer 구현 핵심 코드 내 `propertys` 와 동일
   <br/>

2. **Methods**

   ```swift
   // MARK: - user Interfase Control
    // ...
    // MARK: - controlPausedOrResumed
    // 중지 또는 재개
    func controlTmPausedOrResumed() {
        // 만약 셋팅받은 게 없을 때 막기
        guard let _ = simpleTmRoundIdx, simpleRoundPhase != .completed else {
            return
        }

        controlBtn.toggle()

        if simpleTimerState == .paused {
            controlBtn = false
            simpleTimerState = .resumed
        } else if simpleTimerState == .active {
            controlBtn = true
            simpleTimerState = .paused
        }
    }

    // MARK: - controlBefore
    // 그 이전으로 되돌아가기
    func controlBefore() {
        // 현재가 0일땐 Nothing
        guard let roundIdx = simpleTmRoundIdx, roundIdx >= 0, simpleRoundPhase != .preparation else {
            return
        }

        // 현재 타이머 중지
        simpleTimerState = .paused
        simpleUnitProgress = 0

        if simpleRoundPhase == .completed {
            simpleTmRoundIdx! -= 1
            simpleRoundPhase = .movement
            simpleDisplay = simpleTmRounds[roundIdx-1].movement
            simpleTotalTime = simpleTmRounds[roundIdx-1].movement
            updateBackgroundColor()

            controlBtn = controlBtn

            simpleTimerState = controlBtn ? .paused : .active
            return
        }

        // 현재가 완전 맨 처음인 경우
        if roundIdx == 0 {
            if simpleRoundPhase == .movement { // 운동인 경우 -> 준비 단계로
                simpleRoundPhase = .preparation
                simpleDisplay = selectedPreparationAmount

            } else { // 현재가 첫번째이고 휴식인 경우 -> 운동으로
                simpleDisplay = simpleTmRounds[roundIdx].movement
                simpleRoundPhase = .movement
            }
        } else {
            if simpleRoundPhase == .movement { // 현재가 운동이면 라운드를 앞으로 당겨야함
                // 이전 라운드로 이동
                simpleTmRoundIdx! -= 1
                let currentRound = simpleTmRounds[simpleTmRoundIdx!]
                simpleRoundPhase = .rest
                simpleDisplay = currentRound.rest
            } else { // 휴식인 경우
                simpleRoundPhase = .movement
                simpleDisplay = simpleTmRounds[simpleTmRoundIdx!].movement
            }
        }

        updateBeforeSimpleTotalTime()
        updateBackgroundColor()
        simpleTimerState = controlBtn ? .paused : .active
        return
    }

    // MARK: - controlNext
    // 뒤로(다음) 가기
    func controlNext() {
        // 현재가 마지막 라운드이고 운동 상태라면 nothing
        guard let roundIdx = simpleTmRoundIdx, roundIdx < simpleTmRounds.count else {
            return
        }

        // 현재 타이머 중지
        simpleTimerState = .paused
        simpleUnitProgress = 0
        nextSimpleTimerRoundPhase()
        updateNextSimpleTotalTime()
        return
    }
   ```

   <br/>

</details>

<details>
<summary> 운동 관련 설정 </summary>

| 운동 루프 설정                                                                                                                                        | 준비 설정                                                                                                                    | 휴식 설정                                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| ![운동루프](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%EC%9A%B4%EB%8F%99%EB%A3%A8%ED%94%84%20%EC%84%A4%EC%A0%95.gif?raw=true) | ![준비](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%EC%A4%80%EB%B9%84%EC%84%A4%EC%A0%95.gif?raw=true) | ![휴식](https://github.com/BOLTB0X/WOD-Timer-app/blob/main/history/detail_%ED%9C%B4%EC%8B%9D%EC%84%A4%EC%A0%95.gif?raw=true) |

<br/>

```swift
// MARK: - displayPopup
@ViewBuilder
private func displayPopup() -> some View {
      if isModeBtn == 0 {
          switch detailButton {
            case .preparation:
                DeatilTimerPreparationSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .round:
                DetailTimerRoundSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .preparationColor:
                DeatilTimerPreparationColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            case .loopRestColor:
                DetailTimerRestColorSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            default:
                DetailTimerRestSet(showPopup: $showPopup)
                    .environmentObject(viewModel)
            }
      } else {
          switch detailButton {
          case .preparation:
              DetailStopwatchPreparationSet(showPopup: $showPopup)
                  .environmentObject(viewModel)
          case .round:
              DetailStopwatchRoundSet(showPopup: $showPopup)
                  .environmentObject(viewModel)
          case .preparationColor:
              DeatilStopwatchPreparationColorSet(showPopup: $showPopup)
                  .environmentObject(viewModel)
          case .loopRestColor:
              DetailStopwatchRestColorSet(showPopup: $showPopup)
                  .environmentObject(viewModel)
          default:
              DetailTimerRestSet(showPopup: $showPopup)
                  .environmentObject(viewModel)
          }
      }
} // displayPopup
```

<br/>

1. **운동 관련** : `DetailLoopView`

   ```swift
   // MARK: - DetailLoopView
   struct DetailLoopView: View {
       // MARK: Environment
       @EnvironmentObject private var viewModel: DetailViewModel

       // MARK: State
       // 뷰 관련
       @State private var showPopup: Bool = false
       @State private var showAlert = false
       // 컴포넌트 관련
       @State private var tableType: Int = 0 // 0 Scroll, 1 List
       @State private var selectType: SelectedSetting?

       // MARK: Binding
       @Binding var rootView: Bool
       @Binding var modeBtn: Int

       // MARK: - View
       var body: some View {
           // MARK: main
           NavigationView {
               VStack(alignment: .center,spacing: 0) {
                   DetailLoopTop(
                       tableType: $tableType,
                       betweenRest: modeBtn == 0 ? $viewModel.betweenRestInTimer : $viewModel.betweenRestInStop,
                       createRemoveAction: {
                        viewModel.createRemoveButtonAction(tableType: $tableType, alret: $showAlert, mode: modeBtn)
                       },
                       sortAction: modeBtn == 0 ? viewModel.sortTimerLoopList : viewModel.sortStopLoopList
                   ) // DetailLoopTop

                   Divider()

                   if modeBtn == 0 {
                       displayTimerLoop()
                   } else {
                       displayStopLoop()
                   }

               } // VStack
               // MARK: side
               // MARK: - popupNavigationView
               // 팝업
               .popupNavigationView(show: $showPopup) {
                   if modeBtn == 0 {
                    displayTimerPopup()
                } else {
                    displayStopwatchPopup()
                }
            } // popupNavigationView

            // MARK: - navigationBasicToolbar
            .navigationBasicToolbar(
                backAction: {
                    rootView.toggle()
                },
                title: modeBtn == 0 ? "Timer Movement Loop" :  "Stopwatch Movement Loop"
            ) // navigationBasicToolbar
        } // NavigationView
        // MARK: - alert
        // 경고창
        .alert(isPresented: $showAlert) {
            return Alert(title: Text(viewModel.alretMessage))
        }
    } // body

       // MARK: - ViewBuilder
       // ...
       // MARK: - displayLoop
       @ViewBuilder
       private func displayTimerLoop() -> some View {
           if tableType == 1 { // 편집
               LoopList(
                loopList: $viewModel.timerLoopList,
                multiSelection: $viewModel.multiSelection,
                moveItemFunction: viewModel.moveTimerLoopItem,
                mode: modeBtn
               )

               Divider()

               EditDefaultState(
                defaultMove: $viewModel.defaultMove,
                defaultRest: $viewModel.defaultRest,
                isPopup: $showPopup,
                selectType: $selectType
               )
           } else { // 일반
               LoopScroll(
                loopList: $viewModel.timerLoopList,
                selectedLoopIndex: $viewModel.selectedTimerLoopIndex,
                showPopup: $showPopup,
                selectType: $selectType,
                mode: modeBtn
               )
           } // if - else
       } // displayTimerLoop

       // MARK: - displayLoop
       @ViewBuilder
       private func displayStopLoop() -> some View {
           if tableType == 1 { // 편집
               LoopList(
                   loopList: $viewModel.stopLoopList,
                multiSelection: $viewModel.multiSelection,
                moveItemFunction: viewModel.moveStopLoopItem,
                mode: modeBtn
               )

                Divider()

                EditDefaultState(
                defaultMove: $viewModel.defaultMove,
                defaultRest: $viewModel.defaultRest,
                isPopup: $showPopup,
                selectType: $selectType
               )
              } else { // 일반
                  LoopScroll(
                   loopList: $viewModel.stopLoopList,
                   selectedLoopIndex: $viewModel.selectedStopLoopIndex,
                   showPopup: $showPopup,
                   selectType: $selectType,
                mode: modeBtn
               )
           } // if - else
       } // displayTimerLoop

       // MARK: - displayTimerPopup
       @ViewBuilder
       private func displayTimerPopup() -> some View {
           if let type = selectType {
               switch type {
               case .color, .defaultMoveColor, .defaultRestColor:
                   DetailTimeColorSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)
               case .text, .defaultMoveText, .defaultRestText:
                   DetailTimerTextSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)

               case .defaultMoveTime, .defaultRestTime:
                   DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                    .environmentObject(viewModel)

               default:
                      DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                       .environmentObject(viewModel)
               } // switch
           }
       } // displayTimerPopup

       // MARK: - displayStopwatchPopup
       @ViewBuilder
       private func displayStopwatchPopup() -> some View {
           if let type = selectType {
               switch type {
               case .color, .defaultMoveColor, .defaultRestColor:
                   DetailStopwatchColorSet(showPopup: $showPopup, selectType: $selectType)
                       .environmentObject(viewModel)
               case .text, .defaultMoveText, .defaultRestText:
                   DetailStopwatchTextSet(showPopup: $showPopup, selectType: $selectType)
                       .environmentObject(viewModel)

               default:
                   DetailTimerMovementSet(showPopup: $showPopup, selectType: $selectType)
                       .environmentObject(viewModel)
               } // switch
           }
       } // displayTimerPopup
   }
   ```

   <br/>

2. **준비** : `PreparationSet`

   ```swift
   // MARK: - PreparationSet
   struct PreparationSet: View {
       // MARK: Binding
       @Binding var selectedPreparationAmount: Int
       @Binding var isChange: Bool
       @Binding var showPopup: Bool

       // MARK: 프로퍼티
       let manager: InputManager

       // MARK: - View
       var body: some View {
           GeometryReader { geometry in
               VStack(alignment: .center, spacing: 0) {
                   // MARK: - 초기화 & 전환
                   HStack(alignment: .center, spacing: 0) {
                       Button(action: {selectedPreparationAmount = 3},
                           label: {
                           Image(systemName: "gobackward")
                       })
                       .padding(.horizontal)

                       Spacer()

                       Button(!isChange ? "keyboard": "wheel") {
                           isChange.toggle()
                       }
                       .padding(.horizontal)
                   } // HStack
                   .foregroundColor(.secondary)

                   // MARK: - set
                   if isChange  {
                       SettingTextField(setBinding: $selectedPreparationAmount, title: "Preparation",viewModel: manager)
                   }
                   else {
                       SettingPicker(title: "Preparation",
                                  range: manager.preparationRange,
                                  binding: $selectedPreparationAmount)
                       .onTapGesture {
                           isChange.toggle()
                       }
                   }
               } // VStack
           } // GeometryReader
       } // body
   }
   ```

   <br/>

3. **휴식** : `RestSet`

   ```swift
   // MARK: - RestSet
   struct RestSet: View {
       // MARK: Binding
       @Binding var selectedRestAmount: MovementTime
       @Binding var isChange: Bool
       @Binding var showPopup: Bool
       @Binding var isCalculatedBtn: Bool

       // MARK: 프로퍼티
       let manager: InputManager

       // MARK: - View
       var body: some View {
           GeometryReader { geometry in
               VStack(alignment: .center, spacing: 0) {
                   // MARK: - 초기화 & 전환
                   HStack(alignment: .center, spacing: 0) {
                       Button(action: {
                           selectedRestAmount = MovementTime(hours: 0, minutes: 0, seconds: 10)
                       },
                           label: {
                           Image(systemName: "gobackward")
                       })
                       .padding(.horizontal)

                       Spacer()

                       Button(!isChange ? "keyboard": "wheel") {
                           isChange.toggle()
                       }
                       .padding(.horizontal)
                   } // HStack
                   .foregroundColor(.secondary)

                   // MARK: - set
                   if isChange  {
                       SettingTwoTextField(setMinute: $selectedRestAmount.minutes, setSecond: $selectedRestAmount.seconds, isUsedAuto: $isCalculatedBtn,  viewModel: manager)
                   }
                   else {
                       HStack {
                           SettingPicker(title: "min", range: manager.minutesRange, binding: $selectedRestAmount.minutes)

                           Spacer()

                           SettingPicker(title: "sec", range: manager.secondsRange, binding: $selectedRestAmount.seconds)
                       } // HStack
                       .onTapGesture {
                           isChange.toggle()
                       }
                   }
               } // VStack
           } // GeometryReader
       } // body
   }
   ```

   <br/>

- [운동 루프 원본 코드 보기](https://github.com/BOLTB0X/WOD-Timer-app/tree/main/WOD/Timer/Detail/DetailLoop)
- [셋팅 관련 원본 코드 보기](https://github.com/BOLTB0X/WOD-Timer-app/tree/main/WOD/Timer/Common/View/Setting)

</details>

## Reference

- TextField

  - [TextField 공식문서](https://engineering.linecorp.com/ko/blog/line-pay-swiftui-textfield)
  - [FocusState](https://developer.apple.com/documentation/swiftui/focusstate)
  - [텍스트필드 관련 블로그 1](https://velog.io/@tmdckd232/SwiftUI-TextField-Dismissing-keyboard)
  - [텍스트필드 관련 블로그 2](https://engineering.linecorp.com/ko/blog/line-pay-swiftui-textfield)
    <br/>

- Picker

  - [Picker 공식문서](https://developer.apple.com/documentation/swiftui/picker)
  - [Picker 관련 블로그 ](https://seons-dev.tistory.com/entry/Picker-%EC%99%80-DatePicker)
    <br/>

- Keyboard

  - [키보드 관련](https://ios-development.tistory.com/1068)
    <br/>

- Combine

  - [combine 정리 블로그 참고](https://icksw.tistory.com/category/iOS/Combine?page=3)
  - [multiple Combine publishers 블로그](https://swiftwithmajid.com/2021/05/12/combining-multiple-combine-publishers-in-swift/)
    <br/>

- Timer

  - [참고 타이머 프로젝트 1](https://digitalbunker.dev/recreating-the-ios-timer-in-swiftui/)
  - [참고 타이머 프로젝트 2](https://programmingwithswift.com/build-a-stopwatch-app-with-swiftui/)
  - [Combine Timers](https://cozzin.tistory.com/34)
    <br/>

- Orientation

  - [Orientation - 1](https://sarunw.com/posts/how-to-preview-a-device-in-landscape-orientation-with-swiftui-previews/)

  - [Orientation -2](https://developer.apple.com/forums/thread/126878)
    <br/>

- Audio Toolbox

  - [공식문서 - audiotoolbox](https://developer.apple.com/documentation/audiotoolbox/)
  - [블로그 참조 - AVFoundation 개념](https://ios-development.tistory.com/927)
  - [공식문서 - AVAudioSession](https://developer.apple.com/documentation/avfaudio/avaudiosession)
  - [블로그 참조 - Audiotoolbox 활용](https://medium.com/the-swift-blog/play-short-sound-in-ios-using-audiotoolbox-5ec6a39bab1a)
    <br/>

- Live Activities

  - [Live Activities](https://developer.apple.com/design/human-interface-guidelines/live-activities)
  - [블로그 참조 - Live Activities](https://velog.io/@maddie/iOS-Live-Activity-%EB%9D%BC%EC%9D%B4%EB%B8%8C-%EC%95%A1%ED%8B%B0%EB%B9%84%ED%8B%B0)
  - [Live Activities Timer 참고](https://santoshbotre01.medium.com/empower-your-ios-apps-with-liveactivity-6f2b461e78f3)
    <br/>

- Alert

  - [Medium 참조 1 - Custom Alert](https://levelup.gitconnected.com/custom-alerts-in-swift-using-swiftentrykit-fcb729a69f9ac)
  - [CustomAlertView Github - Custom Alert](https://github.com/devendrabhumca12/CustomAlertView/tree/main)
  - [Custom Dialog Github - Custom Alert](https://github.com/mikina/SwiftUICustomDialog)
    <br/>

- 기타
  - [연산자 오버로딩 참고](https://kka7.tistory.com/73)
  - [async/await](https://azamsharp.medium.com/beginning-async-await-in-ios-15-and-swift-5-5-1086b50b8f3d)
  - [스택오버플로우 참고 - EditButton](https://stackoverflow.com/questions/57344305/swiftui-button-as-editbutton)
    <br/>
