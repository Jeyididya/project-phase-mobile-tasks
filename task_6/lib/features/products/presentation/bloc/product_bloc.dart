import 'dart:async';
import 'package:bloc/bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/insert_product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProduct getProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final InsertProduct insertProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.insertProduct,
  }) : super(InitialState()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<CreateProductEvent>(_onCreateProduct);
  }

  Future<void> _onLoadAllProducts(
    LoadAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final products = await getAllProducts();
      emit(LoadedAllProductsState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onGetSingleProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      final product = await getProduct(event.id);
      emit(LoadedSingleProductState(product));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      await updateProduct(event.product);
      add(LoadAllProductsEvent());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      await deleteProduct(event.id);
      add(LoadAllProductsEvent());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    try {
      await insertProduct(event.product);
      add(LoadAllProductsEvent());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
