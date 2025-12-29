import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadAllProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetSingleProductEvent extends ProductEvent {
  final String id;
  const GetSingleProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  const UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateProductEvent extends ProductEvent {
  final Product product;
  const CreateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}
