Sub AndersExcel_CrackPass()      
        Dim w1 As Worksheet, w2 As Worksheet
        Dim i As Integer, j As Integer, k As Integer, l As Integer
        Dim m As Integer, n As Integer, i1 As Integer, i2 As Integer
        Dim i3 As Integer, i4 As Integer, i5 As Integer, i6 As Integer
        Dim PWord1 As String
        Dim ShTag As Boolean, WinTag As Boolean
        
        Application.ScreenUpdating = False
        With ActiveWorkbook
            WinTag = .ProtectStructure Or .ProtectWindows
        End With
        ShTag = False
        For Each w1 In Worksheets
                ShTag = ShTag Or w1.ProtectContents
        Next w1
        If Not ShTag And Not WinTag Then
            MsgBox MSGNOPWORDS1, vbInformation, HEADER
            Exit Sub
        End If
        MsgBox MSGTAKETIME, vbInformation, HEADER
        If Not WinTag Then
            MsgBox MSGNOPWORDS2, vbInformation, HEADER
        Else
          On Error Resume Next
          Do      'dummy do loop
            For i = 65 To 66: For j = 65 To 66: For k = 65 To 66
            For l = 65 To 66: For m = 65 To 66: For i1 = 65 To 66
            For i2 = 65 To 66: For i3 = 65 To 66: For i4 = 65 To 66
            For i5 = 65 To 66: For i6 = 65 To 66: For n = 32 To 126
            With ActiveWorkbook
              .Unprotect Chr(i) & Chr(j) & Chr(k) & _
                 Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & _
                 Chr(i3) & Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
              If .ProtectStructure = False And _
              .ProtectWindows = False Then
                  PWord1 = Chr(i) & Chr(j) & Chr(k) & Chr(l) & _
                    Chr(m) & Chr(i1) & Chr(i2) & Chr(i3) & _
                    Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
                  MsgBox Application.Substitute(MSGPWORDFOUND1, _
                        "$$", PWord1), vbInformation, HEADER
                  Exit Do  'Bypass all for...nexts
              End If
            End With
            Next: Next: Next: Next: Next: Next
            Next: Next: Next: Next: Next: Next
          Loop Until True
          On Error GoTo 0
        End If
        If WinTag And Not ShTag Then
          MsgBox MSGONLYONE, vbInformation, HEADER
          Exit Sub
        End If
        On Error Resume Next
        For Each w1 In Worksheets
          'Attempt clearance with PWord1
          w1.Unprotect PWord1
        Next w1
        On Error GoTo 0
        ShTag = False
        For Each w1 In Worksheets
          'Checks for all clear ShTag triggered to 1 if not.
          ShTag = ShTag Or w1.ProtectContents
        Next w1
        If ShTag Then
            For Each w1 In Worksheets
              With w1
                If .ProtectContents Then
                  On Error Resume Next
                  Do      'Dummy do loop
                    For i = 65 To 66: For j = 65 To 66: For k = 65 To 66
                    For l = 65 To 66: For m = 65 To 66: For i1 = 65 To 66
                    For i2 = 65 To 66: For i3 = 65 To 66: For i4 = 65 To 66
                    For i5 = 65 To 66: For i6 = 65 To 66: For n = 32 To 126
                    .Unprotect Chr(i) & Chr(j) & Chr(k) & _
                      Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & Chr(i3) & _
                      Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
                    If Not .ProtectContents Then
                      PWord1 = Chr(i) & Chr(j) & Chr(k) & Chr(l) & _
                        Chr(m) & Chr(i1) & Chr(i2) & Chr(i3) & _
                        Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
                      MsgBox Application.Substitute(MSGPWORDFOUND2, _
                            "$$", PWord1), vbInformation, HEADER
                      'leverage finding Pword by trying on other sheets
                      For Each w2 In Worksheets
                        w2.Unprotect PWord1
                      Next w2
                      Exit Do  'Bypass all for...nexts
                    End If
                    Next: Next: Next: Next: Next: Next
                    Next: Next: Next: Next: Next: Next
                  Loop Until True
                  On Error GoTo 0
                End If
              End With
            Next w1
        End If
        MsgBox ALLCLEAR & AUTHORS & VERSION & REPBACK, vbInformation, HEADER
    End Sub