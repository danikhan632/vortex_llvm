; ModuleID = 'kernel'
source_filename = "kernel.cl"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

; Function Attrs: convergent norecurse nounwind
; ModuleID = 'kernel'
source_filename = "kernel.cl"
target datalayout = "e-m:e-p:32:32-i64:64-n32-S128"
target triple = "riscv32-unknown-unknown-elf"

; Function Attrs: convergent norecurse nounwind
define dso_local spir_kernel void @sgemm3(ptr nocapture noundef readonly align 4 %0, ptr nocapture noundef readonly align 4 %1, ptr nocapture noundef writeonly align 4 %2, i32 noundef %3, ptr nocapture noundef align 4 %4, ptr nocapture noundef align 4 %5) local_unnamed_addr #0 !kernel_arg_addr_space !6 !kernel_arg_access_qual !7 !kernel_arg_type !8 !kernel_arg_base_type !8 !kernel_arg_type_qual !9 {
  %7 = tail call i32 @_Z13get_global_idj(i32 noundef 1) #4
  %8 = tail call i32 @_Z13get_global_idj(i32 noundef 0) #4
  %9 = tail call i32 @_Z12get_local_idj(i32 noundef 1) #4
  %10 = tail call i32 @_Z12get_local_idj(i32 noundef 0) #4
  %11 = tail call i32 @_Z14get_local_sizej(i32 noundef 0) #4
  %12 = icmp eq i32 %3, 0
  br i1 %12, label %21, label %13

13:                                               ; preds = %6
  %14 = mul i32 %7, %3
  %15 = add i32 %10, %14
  %16 = mul nsw i32 %11, %9
  %17 = add nsw i32 %16, %10
  %18 = getelementptr inbounds float, ptr %4, i32 %17
  %19 = getelementptr inbounds float, ptr %5, i32 %17
  %20 = icmp sgt i32 %11, 0
  br label %26

21:                                               ; preds = %37, %6
  %22 = phi i32 [ 0, %6 ], [ %14, %37 ]
  %23 = phi float [ 0.000000e+00, %6 ], [ %38, %37 ]
  %24 = add i32 %22, %8
  %25 = getelementptr inbounds float, ptr %2, i32 %24
  store float %23, ptr %25, align 4, !tbaa !10
  ret void

26:                                               ; preds = %13, %37
  %27 = phi i32 [ 0, %13 ], [ %39, %37 ]
  %28 = phi float [ 0.000000e+00, %13 ], [ %38, %37 ]
  %29 = add i32 %15, %27
  %30 = getelementptr inbounds float, ptr %0, i32 %29
  %31 = load float, ptr %30, align 4, !tbaa !10
  store float %31, ptr %18, align 4, !tbaa !10
  %32 = add nsw i32 %27, %9
  %33 = mul i32 %32, %3
  %34 = add i32 %33, %8
  %35 = getelementptr inbounds float, ptr %1, i32 %34
  %36 = load float, ptr %35, align 4, !tbaa !10
; REPLACE: Store to %5 (local memory)
tail call void asm sideeffect "vx_local_sw $0, 0($1)", "r,r"(float %36, ptr %19)

  ; Updated to use two operands for the barrier intrinsic
  tail call void @llvm.riscv.vx.bar(i32 %7, i32 %8) #5

  br i1 %20, label %41, label %37

37:                                               ; preds = %41, %26
  %38 = phi float [ %28, %26 ], [ %51, %41 ]
  
  ; Another barrier usage with two operands
  tail call void @llvm.riscv.vx.bar(i32 %7, i32 %8) #5

  %39 = add nsw i32 %27, %11
  %40 = icmp ult i32 %39, %3
  br i1 %40, label %26, label %21

41:                                               ; preds = %26, %41
  %42 = phi i32 [ %52, %41 ], [ 0, %26 ]
  %43 = phi float [ %51, %41 ], [ %28, %26 ]
  %44 = add nsw i32 %42, %16
  %45 = getelementptr inbounds float, ptr %4, i32 %44
  %46 = load float, ptr %45, align 4, !tbaa !10
  %47 = mul nsw i32 %42, %11
  %48 = add nsw i32 %47, %10
  %49 = getelementptr inbounds float, ptr %5, i32 %48
  %50 = load float, ptr %49, align 4, !tbaa !10
  %51 = tail call float @llvm.fmuladd.f32(float %46, float %50, float %43)
  %52 = add nuw nsw i32 %42, 1
  %53 = icmp eq i32 %52, %11
  br i1 %53, label %37, label %41
}

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z13get_global_idj(i32 noundef) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z12get_local_idj(i32 noundef) local_unnamed_addr #1

; Function Attrs: convergent mustprogress nofree nounwind willreturn memory(none)
declare dso_local i32 @_Z14get_local_sizej(i32 noundef) local_unnamed_addr #1

; Function Attrs: convergent nounwind
declare dso_local void @llvm.riscv.vx.bar(i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

attributes #0 = { convergent norecurse nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-zawrs,-experimental-zca,-experimental-zcd,-experimental-zcf,-experimental-zihintntl,-experimental-ztso,-experimental-zvfh,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xtheadvdot,-xventanacondops,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zihintpause,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" "uniform-work-group-size"="false" }
attributes #1 = { convergent mustprogress nofree nounwind willreturn memory(none) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-zawrs,-experimental-zca,-experimental-zcd,-experimental-zcf,-experimental-zihintntl,-experimental-ztso,-experimental-zvfh,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xtheadvdot,-xventanacondops,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zihintpause,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { convergent nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv32" "target-features"="+32bit,+a,+c,+m,+relax,-d,-e,-experimental-zawrs,-experimental-zca,-experimental-zcd,-experimental-zcf,-experimental-zihintntl,-experimental-ztso,-experimental-zvfh,-f,-h,-save-restore,-svinval,-svnapot,-svpbmt,-v,-xtheadvdot,-xventanacondops,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zdinx,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zicbom,-zicbop,-zicboz,-zihintpause,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { convergent nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!opencl.ocl.version = !{!4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"ilp32"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{i32 2, i32 0}
!5 = !{!"Ubuntu clang version 16.0.6 (15)"}
!6 = !{i32 1, i32 1, i32 1, i32 0, i32 3, i32 3}
!7 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!8 = !{!"float*", !"float*", !"float*", !"uint", !"float*", !"float*"}
!9 = !{!"", !"", !"", !"", !"", !""}
!10 = !{!11, !11, i64 0}
!11 = !{!"float", !12, i64 0}
!12 = !{!"omnipotent char", !13, i64 0}
!13 = !{!"Simple C/C++ TBAA"}