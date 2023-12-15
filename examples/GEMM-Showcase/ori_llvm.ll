; ModuleID = 'matmul.c'
source_filename = "matmul.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.timezone = type { i32, i32 }
%struct.timeval = type { i64, i64 }

@A = dso_local local_unnamed_addr global [2048 x [2048 x double]] zeroinitializer, align 16
@B = dso_local local_unnamed_addr global [2048 x [2048 x double]] zeroinitializer, align 16
@C = dso_local local_unnamed_addr global [2048 x [2048 x double]] zeroinitializer, align 16
@stderr = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [5 x i8] c"%lf \00", align 1
@.str.2 = private unnamed_addr constant [35 x i8] c"Error return from gettimeofday: %d\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c".test\00", align 1
@.str.4 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@t_start = dso_local local_unnamed_addr global double 0.000000e+00, align 8
@t_end = dso_local local_unnamed_addr global double 0.000000e+00, align 8

; Function Attrs: nofree norecurse nounwind uwtable writeonly
define dso_local void @init_array() local_unnamed_addr #0 {
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(33554432) bitcast ([2048 x [2048 x double]]* @C to i8*), i8 0, i64 33554432, i1 false)
  br label %1

1:                                                ; preds = %24, %0
  %2 = phi i64 [ 0, %0 ], [ %25, %24 ]
  br label %3

3:                                                ; preds = %3, %1
  %4 = phi i64 [ 0, %1 ], [ %22, %3 ]
  %5 = add nuw nsw i64 %4, %2
  %6 = trunc i64 %5 to i32
  %7 = sitofp i32 %6 to double
  %8 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @A, i64 0, i64 %2, i64 %4
  store double %7, double* %8, align 16, !tbaa !2
  %9 = mul nuw nsw i64 %4, %2
  %10 = trunc i64 %9 to i32
  %11 = sitofp i32 %10 to double
  %12 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %2, i64 %4
  store double %11, double* %12, align 16, !tbaa !2
  %13 = or i64 %4, 1
  %14 = add nuw nsw i64 %13, %2
  %15 = trunc i64 %14 to i32
  %16 = sitofp i32 %15 to double
  %17 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @A, i64 0, i64 %2, i64 %13
  store double %16, double* %17, align 8, !tbaa !2
  %18 = mul nuw nsw i64 %13, %2
  %19 = trunc i64 %18 to i32
  %20 = sitofp i32 %19 to double
  %21 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %2, i64 %13
  store double %20, double* %21, align 8, !tbaa !2
  %22 = add nuw nsw i64 %4, 2
  %23 = icmp eq i64 %22, 2048
  br i1 %23, label %24, label %3

24:                                               ; preds = %3
  %25 = add nuw nsw i64 %2, 1
  %26 = icmp eq i64 %25, 2048
  br i1 %26, label %27, label %1

27:                                               ; preds = %24
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nofree nounwind uwtable
define dso_local void @print_array() local_unnamed_addr #2 {
  br label %1

1:                                                ; preds = %22, %0
  %2 = phi i64 [ 0, %0 ], [ %24, %22 ]
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  br label %4

4:                                                ; preds = %17, %1
  %5 = phi i64 [ 0, %1 ], [ %18, %17 ]
  %6 = phi %struct._IO_FILE* [ %3, %1 ], [ %20, %17 ]
  %7 = phi i32 [ 0, %1 ], [ %19, %17 ]
  %8 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @C, i64 0, i64 %2, i64 %5
  %9 = load double, double* %8, align 8, !tbaa !2
  %10 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %6, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), double %9) #8
  %11 = trunc i32 %7 to i16
  %12 = urem i16 %11, 80
  %13 = icmp eq i16 %12, 79
  br i1 %13, label %14, label %17

14:                                               ; preds = %4
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  %16 = tail call i32 @fputc(i32 10, %struct._IO_FILE* %15)
  br label %17

17:                                               ; preds = %4, %14
  %18 = add nuw nsw i64 %5, 1
  %19 = add nuw nsw i32 %7, 1
  %20 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  %21 = icmp eq i64 %18, 2048
  br i1 %21, label %22, label %4

22:                                               ; preds = %17
  %23 = tail call i32 @fputc(i32 10, %struct._IO_FILE* %20)
  %24 = add nuw nsw i64 %2, 1
  %25 = icmp eq i64 %24, 2048
  br i1 %25, label %26, label %1

26:                                               ; preds = %22
  ret void
}

; Function Attrs: nofree nounwind
declare dso_local i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local double @rtclock() local_unnamed_addr #4 {
  %1 = alloca %struct.timezone, align 4
  %2 = alloca %struct.timeval, align 8
  %3 = bitcast %struct.timezone* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %3) #9
  %4 = bitcast %struct.timeval* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %4) #9
  %5 = call i32 @gettimeofday(%struct.timeval* nonnull %2, i8* nonnull %3) #9
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %9, label %7

7:                                                ; preds = %0
  %8 = tail call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([35 x i8], [35 x i8]* @.str.2, i64 0, i64 0), i32 %5)
  br label %9

9:                                                ; preds = %0, %7
  %10 = getelementptr inbounds %struct.timeval, %struct.timeval* %2, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !8
  %12 = sitofp i64 %11 to double
  %13 = getelementptr inbounds %struct.timeval, %struct.timeval* %2, i64 0, i32 1
  %14 = load i64, i64* %13, align 8, !tbaa !11
  %15 = sitofp i64 %14 to double
  %16 = fmul fast double %15, 0x3EB0C6F7A0B5ED8D
  %17 = fadd fast double %16, %12
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %4) #9
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %3) #9
  ret double %17
}

; Function Attrs: nofree nounwind
declare dso_local i32 @gettimeofday(%struct.timeval* nocapture, i8* nocapture) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #4 {
  tail call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(33554432) bitcast ([2048 x [2048 x double]]* @C to i8*), i8 0, i64 33554432, i1 false) #9
  br label %1

1:                                                ; preds = %24, %0
  %2 = phi i64 [ 0, %0 ], [ %25, %24 ]
  br label %3

3:                                                ; preds = %3, %1
  %4 = phi i64 [ 0, %1 ], [ %22, %3 ]
  %5 = add nuw nsw i64 %4, %2
  %6 = trunc i64 %5 to i32
  %7 = sitofp i32 %6 to double
  %8 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @A, i64 0, i64 %2, i64 %4
  store double %7, double* %8, align 16, !tbaa !2
  %9 = mul nuw nsw i64 %4, %2
  %10 = trunc i64 %9 to i32
  %11 = sitofp i32 %10 to double
  %12 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %2, i64 %4
  store double %11, double* %12, align 16, !tbaa !2
  %13 = or i64 %4, 1
  %14 = add nuw nsw i64 %13, %2
  %15 = trunc i64 %14 to i32
  %16 = sitofp i32 %15 to double
  %17 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @A, i64 0, i64 %2, i64 %13
  store double %16, double* %17, align 8, !tbaa !2
  %18 = mul nuw nsw i64 %13, %2
  %19 = trunc i64 %18 to i32
  %20 = sitofp i32 %19 to double
  %21 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %2, i64 %13
  store double %20, double* %21, align 8, !tbaa !2
  %22 = add nuw nsw i64 %4, 2
  %23 = icmp eq i64 %22, 2048
  br i1 %23, label %24, label %3

24:                                               ; preds = %3
  %25 = add nuw nsw i64 %2, 1
  %26 = icmp eq i64 %25, 2048
  br i1 %26, label %27, label %1

27:                                               ; preds = %24, %70
  %28 = phi i64 [ %71, %70 ], [ 0, %24 ]
  br label %29

29:                                               ; preds = %65, %27
  %30 = phi i64 [ 0, %27 ], [ %68, %65 ]
  %31 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @C, i64 0, i64 %28, i64 %30
  %32 = load double, double* %31, align 8, !tbaa !2
  %33 = insertelement <2 x double> <double undef, double 0.000000e+00>, double %32, i32 0
  br label %34

34:                                               ; preds = %34, %29
  %35 = phi i64 [ 0, %29 ], [ %63, %34 ]
  %36 = phi <2 x double> [ %33, %29 ], [ %61, %34 ]
  %37 = phi <2 x double> [ zeroinitializer, %29 ], [ %62, %34 ]
  %38 = or i64 %35, 1
  %39 = or i64 %35, 2
  %40 = or i64 %35, 3
  %41 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @A, i64 0, i64 %28, i64 %35
  %42 = bitcast double* %41 to <2 x double>*
  %43 = load <2 x double>, <2 x double>* %42, align 16, !tbaa !2
  %44 = getelementptr inbounds double, double* %41, i64 2
  %45 = bitcast double* %44 to <2 x double>*
  %46 = load <2 x double>, <2 x double>* %45, align 16, !tbaa !2
  %47 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %35, i64 %30
  %48 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %38, i64 %30
  %49 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %39, i64 %30
  %50 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @B, i64 0, i64 %40, i64 %30
  %51 = load double, double* %47, align 8, !tbaa !2
  %52 = load double, double* %48, align 8, !tbaa !2
  %53 = insertelement <2 x double> undef, double %51, i32 0
  %54 = insertelement <2 x double> %53, double %52, i32 1
  %55 = load double, double* %49, align 8, !tbaa !2
  %56 = load double, double* %50, align 8, !tbaa !2
  %57 = insertelement <2 x double> undef, double %55, i32 0
  %58 = insertelement <2 x double> %57, double %56, i32 1
  %59 = fmul fast <2 x double> %54, %43
  %60 = fmul fast <2 x double> %58, %46
  %61 = fadd fast <2 x double> %59, %36
  %62 = fadd fast <2 x double> %60, %37
  %63 = add i64 %35, 4
  %64 = icmp eq i64 %63, 2048
  br i1 %64, label %65, label %34, !llvm.loop !12

65:                                               ; preds = %34
  %66 = fadd fast <2 x double> %62, %61
  %67 = call fast double @llvm.experimental.vector.reduce.v2.fadd.f64.v2f64(double 0.000000e+00, <2 x double> %66)
  store double %67, double* %31, align 8, !tbaa !2
  %68 = add nuw nsw i64 %30, 1
  %69 = icmp eq i64 %68, 2048
  br i1 %69, label %70, label %29

70:                                               ; preds = %65
  %71 = add nuw nsw i64 %28, 1
  %72 = icmp eq i64 %71, 2048
  br i1 %72, label %73, label %27

73:                                               ; preds = %70
  %74 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0))
  %75 = icmp eq %struct._IO_FILE* %74, null
  br i1 %75, label %101, label %76

76:                                               ; preds = %73, %97
  %77 = phi i64 [ %99, %97 ], [ 0, %73 ]
  %78 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  br label %79

79:                                               ; preds = %92, %76
  %80 = phi i64 [ 0, %76 ], [ %93, %92 ]
  %81 = phi %struct._IO_FILE* [ %78, %76 ], [ %95, %92 ]
  %82 = phi i32 [ 0, %76 ], [ %94, %92 ]
  %83 = getelementptr inbounds [2048 x [2048 x double]], [2048 x [2048 x double]]* @C, i64 0, i64 %77, i64 %80
  %84 = load double, double* %83, align 8, !tbaa !2
  %85 = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %81, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), double %84) #10
  %86 = trunc i32 %82 to i16
  %87 = urem i16 %86, 80
  %88 = icmp eq i16 %87, 79
  br i1 %88, label %89, label %92

89:                                               ; preds = %79
  %90 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  %91 = tail call i32 @fputc(i32 10, %struct._IO_FILE* %90) #9
  br label %92

92:                                               ; preds = %89, %79
  %93 = add nuw nsw i64 %80, 1
  %94 = add nuw nsw i32 %82, 1
  %95 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !6
  %96 = icmp eq i64 %93, 2048
  br i1 %96, label %97, label %79

97:                                               ; preds = %92
  %98 = tail call i32 @fputc(i32 10, %struct._IO_FILE* %95) #9
  %99 = add nuw nsw i64 %77, 1
  %100 = icmp eq i64 %99, 2048
  br i1 %100, label %101, label %76

101:                                              ; preds = %97, %73
  ret i32 0
}

; Function Attrs: nofree nounwind
declare dso_local noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare i32 @fputc(i32, %struct._IO_FILE* nocapture) local_unnamed_addr #5

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: nounwind readnone willreturn
declare double @llvm.experimental.vector.reduce.v2.fadd.f64.v2f64(double, <2 x double>) #7

attributes #0 = { nofree norecurse nounwind uwtable writeonly "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #3 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "denormal-fp-math"="preserve-sign,preserve-sign" "denormal-fp-math-f32"="ieee,ieee" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="true" "no-jump-tables"="false" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="true" "use-soft-float"="false" }
attributes #5 = { nofree nounwind }
attributes #6 = { argmemonly nounwind willreturn writeonly }
attributes #7 = { nounwind readnone willreturn }
attributes #8 = { cold }
attributes #9 = { nounwind }
attributes #10 = { cold nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 11.0.0-2~ubuntu20.04.1"}
!2 = !{!3, !3, i64 0}
!3 = !{!"double", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"any pointer", !4, i64 0}
!8 = !{!9, !10, i64 0}
!9 = !{!"timeval", !10, i64 0, !10, i64 8}
!10 = !{!"long", !4, i64 0}
!11 = !{!9, !10, i64 8}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.isvectorized", i32 1}
