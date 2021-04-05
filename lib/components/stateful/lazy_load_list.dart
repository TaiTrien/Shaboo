import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaboo/blocs/connection/connection_cubit.dart';
import 'package:shaboo/blocs/lazy_load/lazyload_bloc.dart';
import 'package:shaboo/components/stateful/lazy_load_item.dart';
import 'package:shaboo/constants/ui_constants.dart';

class LazyLoadList extends StatefulWidget {
  final Widget child;
  final Widget listSeperator;
  final dynamic onRefresh;
  final dynamic onLoadMore;
  const LazyLoadList({Key key, this.child, this.listSeperator, this.onRefresh, this.onLoadMore}) : super(key: key);

  @override
  _LazyLoadListState createState() => _LazyLoadListState();
}

class _LazyLoadListState extends State<LazyLoadList> {
  var _lazyLoadBloc;
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
    _lazyLoadBloc = BlocProvider.of<LazyLoadBloc>(context);
    widget.onRefresh();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
        try {
          widget.onLoadMore();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is InternetDisconnected)
          return Center(
            child: Text(
              'No internet connection',
              style: Theme.of(context).textTheme.headline5.copyWith(color: kGreyColor),
            ),
          );
        return RefreshIndicator(
          onRefresh: () {
            widget.onRefresh();
            return Future.value();
          },
          child: Container(
            child: BlocBuilder<LazyLoadBloc, LazyLoadState>(
              builder: (context, state) {
                if (state is LoadingState)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (state.data == null || state.data.isEmpty) {
                  return Center(
                    child: Text(
                      'There is nothing',
                      style: Theme.of(context).textTheme.headline5.copyWith(color: kGreyColor),
                    ),
                  );
                }
                return ListView.separated(
                  controller: _scrollController,
                  itemCount: state.data == null ? 0 : state.data.length + 1,
                  separatorBuilder: (BuildContext context, int index) {
                    return widget.listSeperator;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (index < state.data.length) {
                      return LazyLoadItem(
                        itemData: state.data[index],
                        child: widget.child,
                      );
                    } else if (state is ErrorState) {
                      return Center(
                        child: Text(state.errorMessage, style: TextStyle(fontSize: 20, color: kGreyColor)),
                      );
                    } else if (state is HasMoreState) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
