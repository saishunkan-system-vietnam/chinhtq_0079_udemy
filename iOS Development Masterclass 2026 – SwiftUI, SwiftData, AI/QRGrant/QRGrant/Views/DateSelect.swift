import SwiftUI

struct DateSelect: View {
  @Binding private var value: Date
  
  @State private var showPicker = false
  @State private var select = Date()
  
  private var selected: Bool
  
  private static let formatter: DateFormatter = {
    let format = DateFormatter()
    format.locale = Locale(identifier: "ja_JP")
    format.calendar = Calendar(identifier: .gregorian)
    format.dateFormat = "yyyy年　MM月　dd日"
    return format
  }()
  
  init(value: Binding<Date>, selected: Bool) {
    self._value = value
    self.selected = selected
  }
  
  var body: some View {
    Text(Self.formatter.string(from: value))
      .frame(maxWidth: .infinity, alignment: .trailing)
      .padding(.vertical, 12)
      .padding(.horizontal, 10)
      .background(
        RoundedRectangle(cornerRadius: 10).fill(.white)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .strokeBorder(.colorBorder, lineWidth: 1.7)
      )
      .font(.system(size: 18, weight: .bold))
      .foregroundStyle(selected ? .black.opacity(0.7) : .colorGrayBG.opacity(0.8))
      .onTapGesture {
        if selected {
          select = value
          showPicker = true
        }
      }.sheet(isPresented: $showPicker) {
        NavigationStack {
          VStack {
            DatePicker("", selection: $select, displayedComponents: .date)
              .datePickerStyle(.graphical)
              .labelsHidden()
              .environment(\.locale, Locale(identifier: "ja_JP"))
              .environment(\.calendar, Calendar(identifier: .gregorian))
              .padding()
          }
          .toolbar {
            ToolbarItem(placement: .cancellationAction) {
              Button { showPicker = false } label: {
                Text("キャンセル")
                  .font(.system(size: 18, weight: .medium))
                  .foregroundStyle(.red)
              }
            }
            ToolbarItem(placement: .confirmationAction) {
              Button { value = select; showPicker = false } label: {
                Text("完了")
                  .font(.system(size: 18, weight: .medium))
                  .foregroundStyle(.blue)
              }
            }
          }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
      }
  }
}
