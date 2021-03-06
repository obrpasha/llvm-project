; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -dse -enable-dse-memoryssa -S %s | FileCheck %s

declare i8* @_Znwm() local_unnamed_addr #0

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

define void @test1(i1 %c) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[COND_TRUE_I_I_I:%.*]], label [[COND_END_I_I_I:%.*]]
; CHECK:       cond.true.i.i.i:
; CHECK-NEXT:    ret void
; CHECK:       cond.end.i.i.i:
; CHECK-NEXT:    [[CALL_I_I_I_I_I:%.*]] = tail call noalias nonnull i8* @_Znam() #2
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8* [[CALL_I_I_I_I_I]] to i64*
; CHECK-NEXT:    tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 [[CALL_I_I_I_I_I]], i8 0, i64 undef, i1 false)
; CHECK-NEXT:    store i64 0, i64* [[TMP0]], align 8
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %cond.true.i.i.i, label %cond.end.i.i.i

cond.true.i.i.i:                                  ; preds = %entry
  ret void

cond.end.i.i.i:                                   ; preds = %entry
  %call.i.i.i.i.i = tail call noalias nonnull i8* @_Znam() #2
  %0 = bitcast i8* %call.i.i.i.i.i to i64*
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %call.i.i.i.i.i, i8 0, i64 undef, i1 false) #3
  store i64 0, i64* %0, align 8
  ret void
}

declare i8* @_Znam() local_unnamed_addr #0


define void @test2(i1 %c) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[CLEANUP_CONT104:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[MUL_I_I_I_I:%.*]] = shl nuw nsw i64 undef, 3
; CHECK-NEXT:    [[CALL_I_I_I_I_I_I131:%.*]] = call noalias nonnull i8* @_Znwm() #2
; CHECK-NEXT:    [[DOTCAST_I_I:%.*]] = bitcast i8* [[CALL_I_I_I_I_I_I131]] to i64*
; CHECK-NEXT:    store i64 0, i64* [[DOTCAST_I_I]], align 8
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* nonnull align 8 [[CALL_I_I_I_I_I_I131]], i8 0, i64 [[MUL_I_I_I_I]], i1 false)
; CHECK-NEXT:    ret void
; CHECK:       cleanup.cont104:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c, label %cleanup.cont104, label %if.then

if.then:                                          ; preds = %entry
  %mul.i.i.i.i = shl nuw nsw i64 undef, 3
  %call.i.i.i.i.i.i131 = call noalias nonnull i8* @_Znwm() #2
  %.cast.i.i = bitcast i8* %call.i.i.i.i.i.i131 to i64*
  store i64 0, i64* %.cast.i.i, align 8
  call void @llvm.memset.p0i8.i64(i8* nonnull align 8 %call.i.i.i.i.i.i131, i8 0, i64 %mul.i.i.i.i, i1 false) #3
  ret void

cleanup.cont104:                                  ; preds = %entry
  ret void
}

attributes #0 = { "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn writeonly }
attributes #2 = { builtin nounwind }
attributes #3 = { nounwind }
