@Preview
@CustomDialog
export struct CalenderDialog {
  controller: CustomDialogController = new CustomDialogController({
    builder: CalenderDialog()
  })

  build() {
      Column(){
        Text("INFORMATION POP UP!")
      }
  }
}